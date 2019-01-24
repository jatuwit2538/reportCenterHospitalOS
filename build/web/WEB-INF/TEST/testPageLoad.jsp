
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="canonical" href="http://www.ninenik.com/demo/pre_loading_status.php"/>
<%@page pageEncoding="utf8" %>
<title>preloading page</title>
<style type="text/css">
html,body{
	height:100%;
	margin:0;
	padding:0;
}
#loadPage{
	position:fixed;
	margin:auto;
	left:0;
	top:0;
	width:100%;
	height:100%;
	color:#FFF;
	background-color:#000;	
	z-index:500;
	text-align:center;
}
</style>

</head>

<body>
<div id="loadPage">
<br />
<br />
<br />
Loding..........
</div>
<p align="center">
<br />
<br />
<br />
<br />
<a href="pre_loading_status.php?1507623102">Load Again</a></p>

<table  id="myTable" width="500" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
<col />
<col />
<col />
<col />
<col />
<thead>
  <tr>
    <td align="center">หัวข้อ</td>
    <td align="center">หัวข้อ</td>
    <td align="center">หัวข้อ</td>
    <td align="center">หัวข้อ</td>
    <td align="center">หัวข้อ</td>
  </tr>
</thead>
 <tbody>
  <tr>
    <td align="center">1</td>
    <td align="center">2</td>
    <td align="center">3</td>
    <td align="center">4</td>
    <td align="center">5</td>
  </tr>
  <tr>
    <td align="center">6</td>
    <td align="center">7</td>
    <td align="center">8</td>
    <td align="center">9</td>
    <td align="center">10</td>
  </tr>
  <tr>
    <td align="center">11</td>
    <td align="center">12</td>
    <td align="center">13</td>
    <td align="center">14</td>
    <td align="center">15</td>
  </tr>
  <tr>
    <td align="center">16</td>
    <td align="center">17</td>
    <td align="center">18</td>
    <td align="center">19</td>
    <td align="center">20</td>
  </tr>
  <tr>
    <td align="center">21</td>
    <td align="center">22</td>
    <td align="center">23</td>
    <td align="center">24</td>
    <td align="center">25</td>
  </tr>
</tbody>     
</table>

<center>
<p><img src="images/edit.png?1507623102" /></p>
<p><img src="images/edit.png?1507623102" /></p>
<p><img src="images/edit.png?1507623102" /></p>
<p><img src="images/edit.png?1507623102" /></p>
<p><img src="images/edit.png?1507623102" /></p>

</center>

<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
$(function(){
	var imgLength=$("img").length; // หาจำนวนรูปทั้งหมด
	var countImg=0; // สำหรับนับจำนวนรูปภาพที่โหลดแล้ว
	$("img").each(function(){
		var IndexID=$("img").index(this); // สำหรับทดสอบ ลบออกได้
		$(this).load(function(){
			countImg++;
			$("#loadPage").append("<br>loaded img "+IndexID); // สำหรับทดสอบ ลบออกได้
		//	console.log("loaded img "+IndexID); // สำหรับทดสอบ ลบออกได้
			if(countImg==imgLength){ // เมื่อโหลดรูปทั้งหมดแล้วปิดตัว loading
				$("#loadPage").hide();
			}			
		});
		// เมื่อเกิดข้อผิดพลาดในการโหลดให้ปิด loading เลย
		$(this).error(function(){ 
			$("#loadPage").hide();
		});
		
	});
});
</script>
</body>
</html>