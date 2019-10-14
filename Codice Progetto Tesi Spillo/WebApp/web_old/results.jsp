<%@ page import="wherexp.VettoriContesto" %>
<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="wherexp.Locale" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Instant &mdash; Free Restaurant Bootstrap 4 Template by uicookies.com</title>
    <meta name="description" content="free Bootstrap 4 Theme by uicookies.com">
    <meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">

    <link href="https://fonts.googleapis.com/css?family=Crimson+Text:400,400i,600|Montserrat:200,300,400, 600, 700" rel="stylesheet">

    <link rel="stylesheet" href="assets/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="assets/fonts/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/magnific-popup.css">
    <link rel="stylesheet" href="css/RadioStyle.css">

    <link rel="stylesheet" href="assets/fonts/fontawesome/css/font-awesome.min.css">


    <link rel="stylesheet" href="assets/css/slick.css">

    <link rel="stylesheet" href="assets/css/helpers.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/restaurant.css">



    <style>
        .button {
            background-color: #675f6b; /* Green */
            border: none;
            color: grey;
            padding: 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin: 4px 2px;
            cursor: pointer;
        }
        .button4 {border-radius: 30px;}
    </style>

    <script>

        function controlloGenerale(){

            controllo = true;

            if (!document.getElementById("pref0_1").checked &&
                !document.getElementById("pref0_2").checked &&
                !document.getElementById("pref0_0").checked){

                controllo = false;

            }
            console.log(controllo);

            if (!document.getElementById("pref1_1").checked &&
                !document.getElementById("pref1_2").checked &&
                !document.getElementById("pref1_0").checked){

                controllo = false;

            }
            console.log(controllo);

            if (!document.getElementById("pref2_1").checked &&
                !document.getElementById("pref2_2").checked &&
                !document.getElementById("pref2_0").checked){

                controllo = false;

            }
            console.log(controllo);

            if (!document.getElementById("pref3_1").checked &&
                !document.getElementById("pref3_2").checked &&
                !document.getElementById("pref3_0").checked){

                controllo = false;

            }
            console.log(controllo);

            if (!document.getElementById("pref4_1").checked &&
                !document.getElementById("pref4_2").checked &&
                !document.getElementById("pref4_0").checked){

                controllo = false;

            }
            console.log(controllo);

            if (!controllo){

                document.getElementById("valuta").disabled = true;
                document.getElementById("valuta").style.color = "grey";

            } else {

                document.getElementById("valuta").disabled = false;
                document.getElementById("valuta").style.color = "white";

            }

        }

    </script>


</head>
<body data-spy="scroll" data-target="#pb-navbar" data-offset="200">


<div class="probootstrap-loader"></div>
<!-- END loader -->

<nav class="navbar navbar-expand-lg navbar-dark pb_navbar pb_scrolled-light" id="pb-navbar">
    <div class="container">
        <a class="navbar-brand d-xl-none d-lg-none d-md-block d-sm-block" href="/">
            <img src="assets/images/restaurant/logo.png" alt="Instant Logo" class="light">
            <img src="assets/images/restaurant/logo-dark.png" alt="Instant Logo" class="dark">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#probootstrap-navbar" aria-controls="probootstrap-navbar" aria-expanded="false" aria-label="Toggle navigation">
            <span><i class="ion-navicon"></i></span>
        </button>
        <div class="collapse navbar-collapse justify-content-md-center" id="probootstrap-navbar">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link text-uppercase pb_letter-spacing-2" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link text-uppercase pb_letter-spacing-2" href="sceltaContesti.jsp">Start</a></li>
                <li class="nav-item logo-center d-xl-block d-lg-block d-md-none d-sm-none d-none">
                    <a class="nav-link text-uppercase pb_letter-spacing-2" href="index.jsp">
                        <img src="assets/images/restaurant/logo.png" alt="Instant Logo" class="light">
                        <img src="assets/images/restaurant/logo-dark.png" alt="Instant Logo" class="dark">
                    </a>
                </li>
                <li class="nav-item"><a class="nav-link text-uppercase pb_letter-spacing-2" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link text-uppercase pb_letter-spacing-2" href="#section-contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- END nav -->

<%



    // Strutture parametri
    ArrayList<Integer> frasiCentroide = new ArrayList<Integer>();
    HashMap<Integer, Integer> frasiSingole = new HashMap<Integer, Integer>();
    int locale = 0;
    String stringaLocale = "";
    String configurazione = "";

    int numeroContesti = frasiSingole.size();

    String spiegazioneCentroide = "";
    String spiegazioneSingole = "";

    if (numeroContesti == 1){
        spiegazioneCentroide += "Ti consiglio questo locale, per il contesto che hai selezionato, ";
    } else {
        spiegazioneCentroide += "Ti consiglio questo locale, per i contesti che hai selezionato, ";
    }

    spiegazioneCentroide += "perchè le persone che ci sono state hanno detto che: <br>";
    spiegazioneSingole = "Ti consiglio questo locale perchè le persone che ci sono state hanno detto che:";



    try{

        // Parametri metodo get
        Map<String, String[]> mappaParametri = request.getParameterMap();


        for (String parametro : mappaParametri.keySet()){

            if (parametro.equals("centroide")){


                for (String frase : mappaParametri.get(parametro)){

                    frasiCentroide.add(Integer.parseInt(frase));

                }

            } else if (parametro.equals("frasiSingole")){

                for (String contestoFrase : mappaParametri.get(parametro)){

                    int contesto = Integer.parseInt(contestoFrase.split(":")[0]);
                    int frase = Integer.parseInt(contestoFrase.split(":")[1]);

                    frasiSingole.put(contesto, frase);

                }

            } else if (parametro.equals("locale")){

                locale = Integer.parseInt(mappaParametri.get(parametro)[0]);
                stringaLocale = mappaParametri.get(parametro)[0];

            } else if (parametro.equals("configurazione")){

                configurazione = mappaParametri.get(parametro)[0];

            }
        }

        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File("filesWherEXP\\frasi singoli items\\intere dat\\"+locale+".dat")));
        HashMap<Integer, String> mappaFrasi = (HashMap<Integer, String>) ois.readObject();
        ois.close();


        int cont = 0;

        for (int frase : frasiCentroide){

            cont++;

            if (cont == 1){

                spiegazioneCentroide += "\"" + mappaFrasi.get(frase) + "\"";

            } else if (cont == 2){

                spiegazioneCentroide += ",<br>e che: \"" + mappaFrasi.get(frase) +"\"";

            } else if (cont == 3){

                spiegazioneCentroide += ";<br>inoltre, hanno detto che: \"" + mappaFrasi.get(frase) +"\"";
            }


        }

        spiegazioneCentroide += ".";

        boolean primo = true;

        for (int c : frasiSingole.keySet()){

            if (primo){
                primo = false;
            } else {
                spiegazioneSingole += ";";
            }

            spiegazioneSingole += "<br>per il contesto " + VettoriContesto.contesti.get(c) + ": \"" + mappaFrasi.get(frasiSingole.get(c)) +"\"";

        }


        spiegazioneSingole += ".";


    } catch (Exception e){

        e.printStackTrace();

    }


%>

<section class="pb_cover_v1 cover-bg-black cover-bg-opacity-4 text-center" style="background-image: url(assets/images/restaurant/1900x1200/img_1.jpg)" id="section-home">
    <div class="container">
        <div class="row align-items-center justify-content-center">
            <div class="col-md-9  order-md-1">

                <p>

                </p>

                <br>
                <p><h3>Spiegazione 1</h3>
                <%
                    out.println(spiegazioneCentroide);
                %>

                </p>
                <br>

                <p>
                <h3>Spiegazione 2</h3>
                <%
                    out.println(spiegazioneSingole);
                %>

                </p>

                <br><br>
                <h1>
                    Valuta le due spiegazioni qui in basso!
                </h1>


            </div>
        </div>
    </div>
</section>

<section>

    <%

        try {


            Scanner infoLocale = new Scanner(new File("filesWherEXP\\info utili\\" + locale + ".txt"));
            Locale l = new Locale();

            l.setId(Integer.parseInt(infoLocale.nextLine()));
            l.setUrl(infoLocale.nextLine());
            l.setNome(infoLocale.nextLine().replaceAll("'", ""));
            l.setTelefono(infoLocale.nextLine().replaceAll("'", ""));
            l.setIndirizzo(infoLocale.nextLine().replaceAll("'", ""));
            l.setCategoria(infoLocale.nextLine().replaceAll("'", ""));

            out.println("Locale: " + l.getNome() + "<br>Indirizzo: " + l.getIndirizzo() +
                    "<br>Telefono: " + l.getTelefono() + "<br>Categoria: " + l.getCategoria() +
                    "<br><img src=\""+l.getUrl()+"\"");

            out.println("<br><br>");



            boolean trovato = false;
            Scanner baseline = new Scanner(new File("filesWherEXP\\baseline.txt"), "UTF-8");
            String spiegazioneBaseline = "Le persone che ci sono state hanno detto che:";

            while (baseline.hasNextLine()){

                String rigaBaseline = baseline.nextLine();
                int localeRigaBaseline = Integer.parseInt(rigaBaseline.split(";")[0]);

                if (locale == localeRigaBaseline){

                    int contestoBaseline = Integer.parseInt(rigaBaseline.split(";")[1]);

                    for (int contesto : frasiSingole.keySet()){

                        if (contesto == contestoBaseline){

                            trovato = true;
                            spiegazioneBaseline += "<br>" + VettoriContesto.contesti.get(contesto) + " -> " + rigaBaseline.split(";")[2];

                        }
                    }

                }

            }

            baseline.close();

            if (!trovato){
                spiegazioneBaseline = "No baseline.";
            }

            out.println(spiegazioneBaseline);





        } catch (Exception e){
            e.printStackTrace();
        }

    %>

    <%

                /*


            ObjectInputStream ois = new ObjectInputStream(new FileInputStream("filesWherEXP\\baseline.dat"));
            HashMap<Integer, HashMap<Integer, String>> obj = (HashMap<Integer, HashMap<Integer, String>>) ois.readObject();
            ois.close();

            if (obj.containsKey(locale)){

                for (int contesto : frasiSingole.keySet()){

                    if (obj.get(locale).containsKey(contesto)){

                        out.print(contesto + " -> " + obj.get(locale).get(contesto)+"<br>");

                    } else {

                        out.println("no contesto " + contesto + "<br>");
                    }

                }

            } else {

                out.println("no locale <br>");
            }





        } catch (Exception e){
            e.printStackTrace();
        }
        */

    %>

</section>

<section>

    <form action="salvaValutzioni" method="get">

        <input type="hidden" id="configurazione" name="configurazione" value="<% out.println(configurazione); %>">
        <input type="hidden" id="locale" name="locale" value="<%out.println(stringaLocale);%>">

        <table align="center">

            <tr>
                <td align="center">
                    <br>
                    <h5 style="color: white">Quale spiegazione preferisci tra le due?</h5>
                    <div class="radio-group" style="height: 45px;">
                        <input onclick="controlloGenerale()" type="radio" id="pref0_1" value="exp1" name="pref0"><label for="pref0_1">Spiegazione 1</label><input onclick="controlloGenerale()" type="radio" id="pref0_2" value="exp2" name="pref0"><label for="pref0_2">Spiegazione 2</label><input onclick="controlloGenerale()" type="radio" id="pref0_0" value="exp0" name="pref0"><label for="pref0_0">Indifferente</label>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <br>
                    <h5 style="color: white">Seleziona ora la spiegazione che ritieni più adatta a queste definizioni</h5>
                </td>
            </tr>

            <tr>
                <td align="center">
                    <br>
                    Ho compreso perchè l'attività mi è stata suggerita<br>
                    <div class="radio-group" style="height: 45px;">
                        <input onclick="controlloGenerale()" type="radio" id="pref1_1" value="exp1" name="pref1"><label for="pref1_1">Spiegazione 1</label><input onclick="controlloGenerale()" type="radio" id="pref1_2" value="exp2" name="pref1"><label for="pref1_2">Spiegazione 2</label><input onclick="controlloGenerale()" type="radio" id="pref1_0" value="exp0" name="pref1"><label for="pref1_0">Indifferente</label>
                    </div>
                </td>
            </tr>

            <tr>
                <td align="center">
                    <br>
                    La spiegazione ha reso il suggerimento più convincente<br>
                    <div class="radio-group" style="height: 45px;">
                        <input onclick="controlloGenerale()" type="radio" id="pref2_1" value="exp1" name="pref2"><label for="pref2_1">Spiegazione 1</label><input onclick="controlloGenerale()" type="radio" id="pref2_2" value="exp2" name="pref2"><label for="pref2_2">Spiegazione 2</label><input onclick="controlloGenerale()" type="radio" id="pref2_0" value="exp0" name="pref2"><label for="pref2_0">Indifferente</label>
                    </div>
                </td>
            </tr>

            <tr>
                <td align="center">
                    <br>
                    La spiegazione mi ha permesso di scoprire nuove informazioni sul locale<br>
                    <div class="radio-group" style="height: 45px;">
                        <input onclick="controlloGenerale()" type="radio" id="pref3_1" value="exp1" name="pref3"><label for="pref3_1">Spiegazione 1</label><input onclick="controlloGenerale()" type="radio" id="pref3_2" value="exp2" name="pref3"><label for="pref3_2">Spiegazione 2</label><input onclick="controlloGenerale()" type="radio" id="pref3_0" value="exp0" name="pref3"><label for="pref3_0">Indifferente</label>
                    </div>
                </td>
            </tr>

            <tr>
                <td align="center">
                    <br>
                    La spiegazione ha incrementato il mio livello di fiducia nel recommender system<br>
                    <div class="radio-group" style="height: 45px;">
                        <input onclick="controlloGenerale()" type="radio" id="pref4_1" value="exp1" name="pref4"><label for="pref4_1">Spiegazione 1</label><input onclick="controlloGenerale()" type="radio" id="pref4_2" value="exp2" name="pref4"><label for="pref4_2">Spiegazione 2</label><input onclick="controlloGenerale()" type="radio" id="pref4_0" value="exp0" name="pref4"><label for="pref4_0">Indifferente</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" >
                    <button class="button button4" type="submit" id="valuta" disabled>Invia valutazione</button>
                </td>
            </tr>
            <br><br>

            <tr>
                <td>
                    <div style="height: 50px">

                    </div>
                </td>
            </tr>

        </table>

    </form>

</section>



<footer class="pb_footer bg-light" role="contentinfo">
    <div class="container">
        <div class="row text-center">
            <div class="col">
                <ul class="list-inline">
                    <li class="list-inline-item"><a href="#" class="p-2"><i class="fa fa-facebook"></i></a></li>
                    <li class="list-inline-item"><a href="#" class="p-2"><i class="fa fa-twitter"></i></a></li>
                    <li class="list-inline-item"><a href="#" class="p-2"><i class="fa fa-instagram"></i></a></li>
                    <li class="list-inline-item"><a href="#" class="p-2"><i class="fa fa-tripadvisor"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col text-center">
                <p>&copy; 2017 <a href="https://uicookies.com/wrapbootstrap/instant">Instant</a>. All Rights Reserved. Designed by <a href="https://uicookies.com/">uiCookies</a></p>
            </div>
        </div>
    </div>
</footer>

<!-- loader -->
<div id="pb_loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#FDA04F"/></svg></div>


<script src="assets/js/jquery.min.js"></script>

<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/slick.min.js"></script>
<script src="assets/js/jquery.mb.YTPlayer.min.js"></script>

<script src="assets/js/jquery.waypoints.min.js"></script>
<script src="assets/js/jquery.easing.1.3.js"></script>

<script src="assets/js/jquery.magnific-popup.min.js"></script>
<script src="assets/js/magnific-popup-options.js"></script>


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="assets/js/google-map.js"></script>

<script src="assets/js/main.js"></script>

</body>
</html>