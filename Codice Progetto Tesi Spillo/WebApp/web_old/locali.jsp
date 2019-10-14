<%@ page import="wherexp.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.ObjectOutputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="sun.reflect.generics.tree.Tree" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: Giuseppe
  Date: 20/07/2019
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>calcolo...</title>
</head>
<body>

<%


    try {

        /*

        // Lettura file item
        FileTestoItems.leggiFiles();
        System.out.println("Lettura file items fatta.");

        // Calcolo IDF lemmi
        VettoreFrase.inizializzaLemmiFraseIDF();
        System.out.println("Vettori Lemmi IDF inizializzati.");

        // Calcolo matrice frase contesto
        MatriceFC.inizializzaMatriceFraseContesto();
        System.out.println("FC inizializzata.");

        // Lettura strutture utili all'esecuzione
        MatriceLF.leggiIDFeLemmi();
        System.out.println("Lemmi e IDF calcolati.");

        // Lettura matrice generata
        MatriceLC.generaMatriceLemmaContestoDaFile();
        System.out.println("LC inizializzata.");

        //Lettura vettori contesto
        VettoriContesto.leggiVettoriContesto();
        System.out.println("Vettori contesto inizializzati");


        MatriceLocaleContesto.calcolaMatrice();
        MatriceLocaleContesto.stampaFileMatriceLocaleContesto();

        */


        MatriceLocaleContesto.leggiMatriceLocaleContesto();
        MatriceLocaleContesto.leggiMatriceLocaleContestoBari();
        MatriceLocaleContesto.leggiMatriceLocaleContestoTorino();
        System.out.println("Matrici locale contesto lette.");



        //MatriceLocaleContesto.leggiMatriceLocaleContesto();
        //System.out.println("Matrice locale contesto letta - " + MatriceLocaleContesto.matriceLocaleContesto.size());



        TreeSet<TreeSet<Integer>> combinazioni = new TreeSet<TreeSet<Integer>>();

        // 5 contesti
        for (int a = 0; a <= 3; a++) {
            for (int b = 3; b <= 6; b++) {
                if (b == 3) b = 0;
                for (int c = 6; c <= 8; c++) {
                    if (c == 6) c = 0;
                    for (int d = 8; d <= 10; d++) {
                        if (d == 8) d = 0;
                        for (int e = 10; e <= 13; e++) {
                            if (e == 10) e = 0;

                            TreeSet<Integer> ins = new TreeSet<Integer>();

                            ins.add(a);
                            ins.add(b);
                            ins.add(c);
                            ins.add(d);
                            ins.add(e);

                            if (ins.contains(0)) ins.remove(0);

                            combinazioni.add(ins);

                            if (e == 0) e = 10;
                        }
                        if (d == 0) d = 8;
                    }
                    if (c == 0) c = 6;
                }
                if (b == 0) b = 3;
            }

        }

        System.out.println("Insiemi creati " + combinazioni.size());

        // contesti -> top 5 item con quel contesto
        TreeMap<TreeSet<Integer>, TreeSet<Integer>> contestiItemBari = new TreeMap<TreeSet<Integer>, TreeSet<Integer>>();

        // per ogni insieme di contesti
        for (TreeSet<Integer> combinazione : combinazioni) {

            TreeMap<Integer, Double> top5ItemScore = new TreeMap<Integer, Double>();

            // per ogni item
            for (int idLocale : MatriceLocaleContesto.matriceLocaleContestoBari.keySet()) {

                // media score contesti
                double mediaScore = 0;

                for (int contesto : combinazione) {

                    System.out.println("Locale: " + idLocale + ", contesto: " + contesto + " --> " +
                            MatriceLocaleContesto.matriceLocaleContestoBari.get(idLocale).get(contesto));

                    mediaScore += MatriceLocaleContesto.matriceLocaleContestoBari.get(idLocale).get(contesto);

                }

                mediaScore /= combinazione.size();

                top5ItemScore.put(idLocale, mediaScore);

            }

            // eliminazione altri item

            if (top5ItemScore.size() > 5){

                ArrayList<Integer> keys = new ArrayList<>();
                ArrayList<Double> values = new ArrayList<>();

                for (Integer l : top5ItemScore.keySet()){

                    keys.add(l);
                    values.add(top5ItemScore.get(l));

                }

                for (int i=0; i<values.size()-1; i++){
                    for (int j=i+1; j<values.size(); j++){

                        if (values.get(i) < values.get(j)){

                            double td = values.get(i);
                            values.set(i, values.get(j));
                            values.set(j, td);

                            int ti = keys.get(i);
                            keys.set(i, keys.get(j));
                            keys.set(j, ti);

                        }

                    }
                }

                top5ItemScore.clear();
                for (int i=0;i<5; i++){
                    top5ItemScore.put(keys.get(i), values.get(i));
                }
            }

            contestiItemBari.put(combinazione, (TreeSet<Integer>) top5ItemScore.keySet());

        }

        System.out.println("Combinazioni trovate");

        PrintWriter pw = new PrintWriter(new File("filesWherEXP\\" + Configurazione.TipoLemmi + "\\combinazioni-items-bari.txt"));

        for (TreeSet<Integer> comb : contestiItemBari.keySet()) {

            System.out.println(comb + " --> " + contestiItemBari.get(comb));
            pw.println(comb + " --> " + contestiItemBari.get(comb));
        }

        pw.flush();
        pw.close();

        System.out.println("Srittura su file di testo completata - Bari");

        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(new File("combinazioni-items-bari.dat")));
        oos.writeObject(contestiItemBari);
        oos.flush();
        oos.close();

        System.out.println("Srittura su file di oggetti completata - Bari");


        // inizio torino

        TreeMap<TreeSet<Integer>, TreeSet<Integer>> contestiItemTorino = new TreeMap<TreeSet<Integer>, TreeSet<Integer>>();

        // per ogni insieme di contesti
        for (TreeSet<Integer> combinazione : combinazioni) {


            TreeMap<Integer, Double> top5ItemScore = new TreeMap<Integer, Double>();

            // per ogni item
            for (int idLocale : MatriceLocaleContesto.matriceLocaleContestoTorino.keySet()) {

                // media score contesti
                double mediaScore = 0;

                for (int contesto : combinazione) {

                    System.out.println("Locale: " + idLocale + ", contesto: " + contesto + " --> " +
                            MatriceLocaleContesto.matriceLocaleContestoTorino.get(idLocale).get(contesto));

                    mediaScore += MatriceLocaleContesto.matriceLocaleContestoTorino.get(idLocale).get(contesto);

                }

                mediaScore /= combinazione.size();

                top5ItemScore.put(idLocale, mediaScore);

            }

            // eliminazione altri item

            if (top5ItemScore.size() > 5){

                ArrayList<Integer> keys = new ArrayList<>();
                ArrayList<Double> values = new ArrayList<>();

                for (Integer l : top5ItemScore.keySet()){

                    keys.add(l);
                    values.add(top5ItemScore.get(l));

                }

                for (int i=0; i<values.size()-1; i++){
                    for (int j=i+1; j<values.size(); j++){

                        if (values.get(i) < values.get(j)){

                            double td = values.get(i);
                            values.set(i, values.get(j));
                            values.set(j, td);

                            int ti = keys.get(i);
                            keys.set(i, keys.get(j));
                            keys.set(j, ti);

                        }

                    }
                }

                top5ItemScore.clear();
                for (int i=0;i<5; i++){
                    top5ItemScore.put(keys.get(i), values.get(i));
                }
            }

            contestiItemTorino.put(combinazione, (TreeSet<Integer>) top5ItemScore.keySet());


        }

        System.out.println("Combinazioni trovate");

        PrintWriter pw2 = new PrintWriter(new File("filesWherEXP\\" + Configurazione.TipoLemmi + "\\combinazioni-items-torino.txt"));

        for (TreeSet<Integer> comb : contestiItemTorino.keySet()) {

            System.out.println(comb + " --> " + contestiItemTorino.get(comb));
            pw2.println(comb + " --> " + contestiItemTorino.get(comb));
        }

        pw2.flush();
        pw2.close();

        System.out.println("Srittura su file di testo completata - Torino");

        ObjectOutputStream oos2 = new ObjectOutputStream(new FileOutputStream(new File("combinazioni-items-torino.dat")));
        oos2.writeObject(contestiItemTorino);
        oos2.flush();
        oos2.close();

        System.out.println("Srittura su file di oggetti completata - Torino");






    } catch (Exception e){

        e.printStackTrace();
    }

%>

</body>
</html>
