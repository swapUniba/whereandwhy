<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
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

    <script>

        function controlloGenerale(){

            controllo = false;

            for (id=1; id<=13; id++){

                if (!document.getElementById(id+"").checked){
                    controllo = true;
                    break;
                }

            }

            if (controllo) {

                document.getElementById("cercaLocale").disabled = false;
                document.getElementById("cercaLocale").style.color = "white";

            } else {

                document.getElementById("cercaLocale").disabled = true;
                document.getElementById("cercaLocale").style.color = "grey";

            }

        }

        function controlloSingolo(id) {

            if (id == "1" || id == "2" || id == "3"){

                if (id == "1"){

                    if (document.getElementById("1").checked){

                        document.getElementById("1").style.background = "#675f6b";
                        document.getElementById("2").style.background = "transparent";
                        document.getElementById("3").style.background = "transparent";


                    } else {

                        document.getElementById("1").style.background = "transparent";
                    }

                } else if (id == "2"){

                    if (document.getElementById("2").checked){

                        document.getElementById("2").style.background = "#675f6b";
                        document.getElementById("1").style.background = "transparent";
                        document.getElementById("3").style.background = "transparent";


                    } else {

                        document.getElementById("1").style.background = "transparent";
                    }

                } else {

                    if (document.getElementById("3").checked){

                        document.getElementById("3").style.background = "#675f6b";
                        document.getElementById("2").style.background = "transparent";
                        document.getElementById("1").style.background = "transparent";


                    } else {

                        document.getElementById("1").style.background = "transparent";
                    }

                }

            }

        }


    </script>

    <style>
        .button {
            background-color: #675f6b;
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

<section class="pb_cover_v1 cover-bg-black cover-bg-opacity-4 text-center" style="background-image: url(assets/images/restaurant/1900x1200/img_1.jpg)" id="section-home">
    <div class="container">
        <div class="row align-items-center justify-content-center">
            <div class="col-md-9  order-md-1">

                <!-- <h3 class="heading mb-3">WherEXP</h3> --><br><br><br>
                <!--  <div class="sub-heading"><p class="mb-5">Ora dicci che tipo di giornata vuoi trascorrere...</p></div> -->
                <div class="sub-heading">Ora dicci che tipo di giornata vuoi trascorrere...</div>

                <form action="gestioneRichiesta" method="get">
                    <b>
                        <table align="center">

                            <tr>
                                <td colspan="2">
                                    Città<br>
                                    <div class="radio-group" style="height: 45px;">
                                        <input onclick="controlloGenerale()"  type="radio" id="bari" value="bari" name="citta" checked><label for="bari">Bari</label><input onclick="controlloGenerale()"type="radio" id="torino" value="torino" name="citta"><label for="torino">Torino</label>
                                    </div>
                                </td>
                            </tr>

                            <tr>

                                <td>

                                    Tipo di pasto<br>
                                    <div class="radio-group" style="height: 45px;">
                                        <input onclick="controlloGenerale(); controlloSingolo(this.id)" type="radio" id="1" value="1" name="pasto"><label for="1">Colazione</label><input onclick="controlloGenerale(); controlloSingolo(this.id)" type="radio" id="2" value="2" name="pasto"><label for="2">Pranzo</label><input onclick="controlloGenerale(); controlloSingolo(this.id)" type="radio" id="3" value="3" name="pasto"><label for="3">Cena</label>
                                    </div>

                                </td>

                                <td>

                                    Compagnia<br>
                                    <div class="radio-group" style="height: 45px;">
                                        <input type="radio" id="4" value="4" name="compagnia" ><label for="4">Famiglia</label><input type="radio" id="5" value="5" name="compagnia" ><label for="5">Coppia</label><input type="radio" id="6" value="6" name="compagnia"><label for="6" >Amici</label>
                                    </div>

                                </td>
                            </tr>

                            <tr>

                                <td>
                                    Giorno della settimana<br>
                                    <div class="radio-group" style="height: 45px;">
                                        <input onclick="controlloGenerale()" type="radio" id="7" value="7" name="giorno"><label for="7">Feriale</label><input onclick="controlloGenerale()" type="radio" id="8" value="8" name="giorno"><label for="8">Festivo</label>
                                    </div>

                                </td>

                                <td>
                                    Umore<br>
                                    <div class="radio-group" style="height: 45px;">
                                        <input onclick="controlloGenerale()" type="radio" id="9" value="9" name="umore"><label for="9">Buon umore</label><input onclick="controlloGenerale()" type="radio" id="10" value="10" name="umore"><label for="10">Cattivo umore</label>
                                    </div>

                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">
                                    Tipo di cibo<br>
                                    <div class="radio-group" style="height: 45px;">
                                        <input onclick="controlloGenerale()" type="radio" id="11" value="11" name="cibo"><label for="11">Cibo salutare</label><input onclick="controlloGenerale()" type="radio" id="12" value="12" name="cibo"><label for="12">Cibo non salutare</label><input onclick="controlloGenerale()" type="radio" id="13" value="13" name="cibo"><label for="13">Esigenze alimentari</label>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <button class="button button4" type="submit" id="cercaLocale" disabled>Cerca locale</button>
                                </td>
                            </tr>

                        </table>
                    </b>
                </form>

            </div>
        </div>
    </div>
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