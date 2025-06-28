<?php

require_once 'Conexion.php';

class Publisher extends Conexion{
  private $pdo;

  //Documentacion
  public function __CONSTRUCT(){
    $this->pdo = parent::getConexion();
  }
  
  /**
   * Retorna una listaa conteniendo todos los publisher y los totales de acuerdo a los superheroes
   * @return array Retorna un arreglo asociativo conteniendo el resultado de la consulta
   */
  public function getAll(){
    try{
      $query = $this->pdo->prepare("SELECT*FROM vs_publisher_count");
      $query->execute();
      return $query->fetchAll(PDO::FETCH_ASSOC);
    }catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function getById($params=[]){
    try{
      $query = $this->pdo->prepare("CALL spu_publisherid(?)");
      $query->execute(
        array($params['id'])
      );
      return $query->fetchAll(PDO::FETCH_ASSOC);
    }catch(Exception $e){
      die($e->getMessage());
    }
  }

}
//  $pb = new Publisher();

//  echo json_encode($pb->getById(['id'=>5]));