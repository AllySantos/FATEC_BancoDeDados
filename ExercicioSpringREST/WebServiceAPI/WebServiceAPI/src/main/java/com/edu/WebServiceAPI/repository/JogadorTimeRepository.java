package com.edu.WebServiceAPI.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.edu.WebServiceAPI.model.entity.JogadorTime;

public interface JogadorTimeRepository extends JpaRepository<JogadorRepository, Integer>{

	JogadorTime udfJogadorIdade(int codigo);
}
