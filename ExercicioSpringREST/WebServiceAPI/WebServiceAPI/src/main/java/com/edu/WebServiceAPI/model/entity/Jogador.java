package com.edu.WebServiceAPI.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(name = "Jogador")
@NamedNativeQuery(
        name = "Jogador.findJogadoresDataConv",
        query = "select j.codigo, j.nomeJogador, j.sexo, j.altura, convert(char(10), j.dt_nasc, 103) as dt_nasc, j.id_time, t.id, t.nome, t.cidade " +
                "from jogador j, times where j.id_time = t.id",
        resultClass = Jogador.class

)

@NamedNativeQuery(
        name = "Jogador.findJogadorDataConv",
        query = "select j.codigo, j.nomeJogador, j.sexo, j.altura, convert(char(10), j.dt_nasc, 103) as dt_nasc, j.id_time, t.id, t.nome, t.cidade " +
                "from jogador j, times where j.id_time = t.id " +
                "and j.codigo = ?1",
        resultClass = Jogador.class

)
public class Jogador {

    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigo;

    @Column
    private String nomeJogador;

    @Column
    private String sexo;

    @Column
    private float altura;

    @Column
    private String dt_nasc;

    @ManyToOne(targetEntity = Times.class)
    @JoinColumn(name = "id_time") //coluna de FK la no banco

    private Times times;



    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNomeJogador() {
        return nomeJogador;
    }

    public void setNomeJogador(String nomeJogador) {
        this.nomeJogador = nomeJogador;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public float getAltura() {
        return altura;
    }

    public void setAltura(float altura) {
        this.altura = altura;
    }

    public String getDt_nasc() {
        return dt_nasc;
    }

    public void setDt_nasc(String dt_nasc) {
        this.dt_nasc = dt_nasc;
    }

    public Times getTimes() {
        return times;
    }

    public void setTimes(Times times) {
        this.times = times;
    }

    @Override
    public String toString() {
        return "Jogador{" +
                "codigo=" + codigo +
                ", nomeJogador='" + nomeJogador + '\'' +
                ", sexo='" + sexo + '\'' +
                ", altura=" + altura +
                ", dt_nasc='" + dt_nasc + '\'' +
                ", times=" + times +
                '}';
    }
}
