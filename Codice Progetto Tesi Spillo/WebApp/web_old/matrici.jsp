<%@ page import="wherexp.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.TreeMap" %><%--
  Created by IntelliJ IDEA.
  User: Giuseppe
  Date: 23/07/2019
  Time: 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%

    try {
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

        CombinazioniItems.leggiCombinazioniBari();
        CombinazioniItems.leggiCombinazioniTorino();
        System.out.println("Matrice contesti locali lette.");

        MatriceContestiItemFrasi.inizializzaCombinazioni();
        System.out.println("Combinazioni elaborate.");


        //MatriceContestiItemFrasi.inizializzaMatriceBari();
        MatriceContestiItemFrasi.scriviMatriceBari();
        System.out.println("Matrice contesti-item-frasi Bari scritta.");

        /*
        MatriceContestiItemFrasi.inizializzaMatriceTorino();
        MatriceContestiItemFrasi.scriviMatriceTorino();
        System.out.println("Matrice contesti-item-frasi Torino scritta.");
        */



        System.out.println("END");

    } catch (Exception e){

        e.printStackTrace();
    }
%>

</body>
</html>
