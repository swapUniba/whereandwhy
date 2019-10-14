# -*- coding: utf-8 -*-
"""
Created on Thu May 16 16:31:17 2019

@author: Giuseppe
"""

import time
import requests

numero_richieste = 0

# La funzione elabora la richiesta della sentiment analysis 
# e restituisce l'esito, che può essere "POSITIVE", "NEUTRAL", "NEGATIVE"
def sentiment(text):
    
    global numero_richieste
    
    # Indirizzo server
    SERVER_PATH = "http://api.italianlp.it"

    # Dati da impacchettare per la richiesta
    payload = {'text': text,
               'lang': "IT",
               'async': "true",
               'extra_tasks': ["sentiment"]}
    
    
     
    
    eccezione = False

    # Elaborazione richiesta
    while True:
        
        
        try:
            
            if (eccezione == True):
                
                print("sentiment - attendo 30 secondi...")
                time.sleep(30)
                print("30 secondi passati")
                
            #if (numero_richieste % 20 == 0):
                
                #time.sleep(5)
                
            # Loading document, requesting both syntax and named_entity tasks 
            
            #time.sleep(1)
            
            r = requests.post(SERVER_PATH + '/documents/', payload)    
            id_doc = r.json()['id'] 
            
            #time.sleep(2)
            
            result = requests.get(SERVER_PATH + '/documents/details/%s?page=%s' % (id_doc, 1))
            json_value = result.json()
            
            numero_richieste += 1
            
            # Controllo validità risposta
            if json_value ['sentiment_value']== '':
                
                time.sleep(1)
                print ("STOP sentiment")
                continue
    
            # Ottenimento risposta
            sentiment = json_value['sentiment_value']
            
            break
        
        except:
            
            print("Eccezione sentiment")
            eccezione = True
            print("Fatte " + repr(numero_richieste) + " richieste")
            
            exceptionPath = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\eccezioni.txt'
            fileeccezioni = open(exceptionPath, "a", encoding="utf-8")

            fileeccezioni.write("Eccezione sentiment. Fatte " + repr(numero_richieste) + " richieste\n")
            fileeccezioni.flush()
            fileeccezioni.close()
        

    # Restituione esito
    return (sentiment)

def syntax(text):
    
    global numero_richieste
    
    SERVER_PATH = "http://api.italianlp.it"

    payload = {'text': text,
               'lang': "IT",
               'async': "true",
               'extra_tasks': ["syntax"]}
    
      
    
    eccezione = False
    #----------------------------------------------------------------------------------
    while True:
        
        try:
            
            if (eccezione == True):
                
                print("syntax - attendo 30 secondi...")
                time.sleep(30)
                print("30 secondi passati")
                
            #if (numero_richieste % 20 == 0):
                
            #    time.sleep(5)
                
            # Loading document, requesting both syntax and named_entity tasks
            
            #time.sleep(1)
            
            r = requests.post(SERVER_PATH + '/documents/', payload)            
            id_doc = r.json()['id']
            
            #time.sleep(2)
            
            result = requests.get(SERVER_PATH + '/documents/details/%s?page=%s' % (id_doc, 1))
            json_value = result.json()
            
            numero_richieste += 1
            
            if json_value['sentences']['count'] == 0:
                
                    time.sleep(1)
                    print ("STOP syntax")
                    continue
    
            aggiunta = True
            
            toks = []
            
            for sentence in json_value['sentences']['data']: 
                
                for t in sentence['tokens']:
                    
                    if (t['pos'] == 'S' or t['pos'] == 'V' or t['pos'] == 'B' or t['pos'] == 'A'):
                        toks.append(t['lemma'])
                        
                    if (t['per'] == "1"):
                        aggiunta = False
                
            break
            
        except:    # This is the correct syntax
            
            print("Eccezione syntax")
            eccezione = True
            print("Fatte " + repr(numero_richieste) + " richieste")
            
            exceptionPath = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\eccezioni.txt'
            fileeccezioni = open(exceptionPath, "a", encoding="utf-8")

            fileeccezioni.write("Eccezione syntax. Fatte " + repr(numero_richieste) + " richieste\n")
            fileeccezioni.flush()
            fileeccezioni.close()
            
    #print(json_value)
    
    if (aggiunta == False):
        toks = []
    
    return (toks)

def tokenization(testo):
    
    # Tolgo terminatori di frasi e li trasformo in punti
    testo = testo.replace("!",".")
    testo = testo.replace("?",".")
    
    # Suddivido la recensione per punti
    frasix = testo.split(".")
    
    # Array di frasi vuoto
    frasi = []
    
    # Per ogni frase
    for f in frasix:        
        
        # trim frase
        f = f.strip()
        
        # Aggiungo la frase all'array di frasi
        frasi.append(f)
        
    return frasi



inpath = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\dataset.txt'
outpathIntere = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\idFrasefrasiIntere.txt'
outpathLemmiUni = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\idFraseLemmiUni.txt'
outpathLemmiBi = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\idFraseLemmiBi.txt'
outpathLemmiUniBi = 'C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\items\\input\\prova\\idFraseLemmiUniBi.txt'


fileinput = open(inpath, "r", encoding="utf-8")
fileoutputIntere = open(outpathIntere, "a", encoding="utf-8")
fileoutputLemmiUni = open(outpathLemmiUni, "a", encoding="utf-8")
fileoutputLemmiBi = open(outpathLemmiBi, "a", encoding="utf-8")
fileoutputLemmiUniBi = open(outpathLemmiUniBi, "a", encoding="utf-8")



numero_richieste = 0

#contatori frasi e recensioni
counterFrasi = 0
counterRecensioni = 0

for recensione in fileinput:
    
    counterRecensioni += 1
    
    # divisione id recensione da testo
    r = recensione.split(';')
    
    # ottenimento id locale e testo recensione
    idLocale = r[0]
    testoRece = r[1]
    
    # ottenimento testo tokenizzato della recensione
    frasiRecensione = tokenization(testoRece)
    
    # se ho almeno una frase
    if (len(frasiRecensione)):
        
        # per ogni frase
        for f in frasiRecensione:    
            
            # eliminazione spazi
            f = f.strip()            
        
            # controllo lunghezza frase
            if (len(f) > 0 and sentiment(f) == 'POSITIVE'):
                
                # lemmi della frase
                lemmi = syntax(f)
                
                #considero solo le frasi con almeno due parole
                if  (len(lemmi) >= 2):
                
                    # preparazione righe da stampare sui file
                    rigaFileIntere = idLocale + ";" + repr(counterFrasi) + ";" + f
                    rigaFileLemmiUni = idLocale + ";" + repr(counterFrasi) + ";"
                    rigaFileLemmiBi = idLocale + ";" + repr(counterFrasi) + ";"
                    rigaFileLemmiUniBi = idLocale + ";" + repr(counterFrasi) + ";"
                    
                    # variabili controllo
                    primo = True
                    i = 0        
                    
                    # stringa da scrivere inizializzata
                    stringaLemmiUni = ""
                    stringaLemmiBi = ""
                    stringaLemmiUniBi = ""
                    
                    # per ogni lemma
                    while(i<len(lemmi)-1):
                        
                        # controllo aggiunta virgola
                        if (primo == False):
                            stringaLemmiUni += ", "
                            stringaLemmiBi += ", "
                            
                    
                        # aggiunta lemma alla stringa degli unigrammi
                        stringaLemmiUni += lemmi[i].lower()
            
                        # aggiunta lemmi allla stringa dei bigrammi
                        stringaLemmiBi += lemmi[i].lower() + " " + lemmi[i+1].lower()
                        
                        primo = False
                        i += 1
                    
                    # aggiunta ultimo lemma alla stringa degli unigrammi
                    stringaLemmiUni += ", " + lemmi[len(lemmi)-1]
                
                    # se la stringa costruita ha lunghezza maggiore di 0
                    if (len(stringaLemmiUni.strip()) != 0):
                        
                        counterFrasi += 1
                        
                        # stampa su file riga unigrammi
                        fileoutputLemmiUni.write(rigaFileLemmiUni + stringaLemmiUni + '\n')                
                        
                        # stampa su file riga bigrammi
                        fileoutputLemmiBi.write(rigaFileLemmiBi + stringaLemmiBi + '\n')
                        
                        # stampa su file riga unigrammi e bigrammi
                        fileoutputLemmiUniBi.write(rigaFileLemmiUniBi + stringaLemmiUni + ", " + stringaLemmiBi + '\n')
                        
                        # stampa su file frase intera
                        fileoutputIntere.write(rigaFileIntere + '\n')
                        
                        # stampa a schermo
                        print(rigaFileIntere)
                        print(rigaFileLemmiUni + stringaLemmiUni)
                        print(rigaFileLemmiBi + stringaLemmiBi)
                        print(rigaFileLemmiUniBi + stringaLemmiUni + ", " + stringaLemmiBi + '\n')
                    
                        if (counterFrasi % 50 == 0):
                            
                            fileoutputIntere.flush()
                            fileoutputLemmiUni.flush()
                            fileoutputLemmiBi.flush()
                            fileoutputLemmiUniBi.flush()

# flush e chiusura file

fileoutputIntere.flush()
fileoutputIntere.close()

fileoutputLemmiUni.flush()
fileoutputLemmiUni.close()

fileoutputLemmiBi.flush()
fileoutputLemmiBi.close()

fileoutputLemmiUniBi.flush()
fileoutputLemmiUniBi.close()

fileinput.close()

















