<?php

class Carro
{
    private $id;
    private $marca;
    private $km;
    private $cor;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }
    public function getMarca()
    {
        return $this->marca;
    }

    public function setMarca($marca)
    {
        $this->marca = $marca;
    }
    public function getKm()
    {
        return $this->km;
    }

    public function setKm($km)
    {
        $this->km = $km;
    }
    public function getCor()
    {
        return $this->cor;
    }

    public function setCor($cor)
    {
        $this->cor = $cor;
    }
}

    interface CarroDAOinterface {
        public function create(Car $car);
        public function findAll();
    }
