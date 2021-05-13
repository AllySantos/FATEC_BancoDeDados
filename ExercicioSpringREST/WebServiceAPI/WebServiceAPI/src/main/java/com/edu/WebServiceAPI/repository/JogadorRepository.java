package com.edu.WebServiceAPI.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.edu.WebServiceAPI.model.entity.Jogador;

public interface JogadorRepository extends JpaRepository<Jogador, Integer>{

	List<Jogador> findJogadoresDataConv();
	Jogador findJogadorDataConv(int codigo);
}
