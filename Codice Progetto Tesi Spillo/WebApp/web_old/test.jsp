<%@ page import="java.util.Map" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head><title></title></head>
<body>

<%

        out.println(request.getParameter("pasto") + " - " + request.getParameter("compagnia"));

        Map<String, String[]> param = request.getParameterMap();

        for (String p : param.keySet()){

                out.println(p + " - " + param.get(p)[0]);
        }

%>

</body>
</html>

