package com.edu.WebServiceAPI.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import com.edu.WebServiceAPI.model.entity.Times;

public interface TimesRepository extends JpaRepository<Times, Integer> {

	@Procedure(name = "Times.spCrudTimes")
	String spCrudTimes(@Param("cod") String cod,
						@Param("id") int id,
						@Param("nome") String nome,
						@Param("cidade") String cidade);
	
}
