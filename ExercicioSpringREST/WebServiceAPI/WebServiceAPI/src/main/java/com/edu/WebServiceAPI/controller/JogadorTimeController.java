package com.edu.WebServiceAPI.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.WebServiceAPI.model.DTO.JogadorDTO;
import com.edu.WebServiceAPI.model.DTO.TimesDTO;
import com.edu.WebServiceAPI.model.entity.JogadorTime;
import com.edu.WebServiceAPI.repository.JogadorTimeRepository;

@RestController
@RequestMapping("/api")
public class JogadorTimeController {

	@Autowired
	private JogadorTimeRepository jTimeRep;
	
	@GetMapping("/jogador/idade/{codigo}")
	public ResponseEntity<JogadorDTO> getJogadorIdade(@PathVariable(value = "codigo") int codigo){
		JogadorTime j = jTimeRep.udfJogadorIdade(codigo);
		JogadorDTO jDTO = converteJogadorTime(j);
		
		return ResponseEntity.ok().body(jDTO);
	}
	
	private JogadorDTO converteJogadorTime(JogadorTime j) {
		JogadorDTO jDto = new JogadorDTO();
		jDto.setCodigo(j.getCodigo());
		jDto.setAltura(j.getAltura());
		jDto.setDt_nasc(j.getDt_nasc());
		jDto.setSexo(j.getSexo());
		jDto.setNomeJogador(j.getNomeJogador());
		jDto.setIdade(j.getIdade());

		TimesDTO tDTO = new TimesDTO();
		tDTO.setId(j.getId());
		tDTO.setNome(j.getNome());
		tDTO.setCidade(j.getCidade());
		
		jDto.setTimes(tDTO);
		
		
		
		return jDto;
	}
}
