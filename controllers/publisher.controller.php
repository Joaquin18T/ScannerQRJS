<?php

require_once '../models/Publisher.php';
$pb = new Publisher();


if(isset($_GET['operacion'])){
  
  switch($_GET['operacion']){
    case 'getAll':
      echo json_encode($pb->getAll());
      break;
    case 'getById':
      echo json_encode($pb->getById(['id'=>$_GET['id']]));
  }
}