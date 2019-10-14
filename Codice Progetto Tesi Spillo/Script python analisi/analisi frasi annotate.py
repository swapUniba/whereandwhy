# -*- coding: utf-8 -*-
"""
Created on Sat May 18 18:56:26 2019

@author: Giuseppe
"""
import requests
import time


def syntax(text):
    SERVER_PATH = "http://api.italianlp.it"

    payload = {'text': text,
               'lang': "IT",
               'async': "true",
               'extra_tasks': ["syntax"]}
    
    # Loading document, requesting both syntax and named_entity tasks
    r = requests.post(SERVER_PATH + '/documents/', payload)
    
    id_doc = r.json()['id']  
    #----------------------------------------------------------------------------------
    while True:
        
        try:
            
            time.sleep(1.5)
            result = requests.get(SERVER_PATH + '/documents/details/%s?page=%s' % (id_doc, 1))
            json_value = result.json()
            
            if json_value['sentences']['count'] == 0:
                    time.sleep(3)
                    print ("STOP")
                    continue
    
            toks = []
            for sentence in json_value['sentences']['data']: 
                for t in sentence['tokens']:
                    
                    if (t['pos'] == 'S' or t['pos'] == 'V' or t['pos'] == 'B' or t['pos'] == 'A'):
                        toks.append(t['lemma'])
                
            break
            
        except requests.exceptions.RequestException as e:    # This is the correct syntax
            print(e)
            
            
    #print(json_value)
    return (toks)



pathinput = "C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\fileinput\\ngrammi\\idFraseTesto.txt"
pathOutputUni = "C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\fileinput\\ngrammi\\idFraseLemmiUni.txt"
pathOutputBi = "C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\fileinput\\ngrammi\\idFraseLemmiBi.txt"
pathOutputUniBi = "C:\\Users\\Giuseppe\\Desktop\\DepecheMoodLike\\fileinput\\ngrammi\\idFraseLemmiUniBi.txt"


infile = open(pathinput, "r", encoding="utf-8")
outUni = open(pathOutputUni, "w", encoding="utf-8")
outBi = open(pathOutputBi, "w", encoding="utf-8")
outUniBi = open(pathOutputUniBi, "w", encoding="utf-8")


for riga in infile:
    
    #riga è la riga del file, nel formato <idFrase>;<testo>
    idFrase = riga.split(';')[0]
    testoFrase = riga.split(';')[1]
    
    #costruzione riga del file di output di unigrammi
    rigaoutUni = idFrase + ";"
    rigaoutBi = ""
    
    #variabile di controllo
    primo = True
    
    #analisi sintattica frase
    lemmiFrase = syntax(testoFrase)
    
    #dimensione lemmi frase
    n = len(lemmiFrase)
    
    # considero solo le frasi con almeno due parole
    if (n>=2):        
    
        #indice array
        i = 0
        
        #scorrimento lemmi frase
        while(i < n-1):
            
            #se non è il primo lemma aggiungo la virgola
            if(primo == False):            
                rigaoutUni += ", "
                rigaoutBi += ", "
            
            #aggiunta lemma alla frase
            rigaoutUni += lemmiFrase[i]
            rigaoutBi += lemmiFrase[i] + " " + lemmiFrase[i+1]
            primo = False
            
            i += 1
        rigaoutUni = rigaoutUni + ", " + lemmiFrase[n-1]  
        # riga unigrammi -> pronta
        # riga bigrammi -> va aggiunta intestazione
        # riga unigrammi e bigrammi -> aggiungere alla riga unigrammi la riga bigrammi
        
        rigaoutUniBi = rigaoutUni + ", " + rigaoutBi
        rigaoutBi = idFrase + ";" + rigaoutBi
            
        #scrittura su file    
        outUni.write(rigaoutUni + "\n")
        outBi.write(rigaoutBi + "\n")
        outUniBi.write(rigaoutUniBi + "\n")
        
        #stampa a schermo
        print(rigaoutUni)
        print(rigaoutBi)
        print(rigaoutUniBi)

#flush file    
outUni.flush()
outBi.flush()
outUniBi.flush()

#chiusura file
outUni.close()
outBi.close()
outUniBi.close()
infile.close()















