package com.edu.WebServiceAPI.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.WebServiceAPI.model.DTO.JogadorDTO;
import com.edu.WebServiceAPI.model.DTO.TimesDTO;
import com.edu.WebServiceAPI.model.entity.Jogador;
import com.edu.WebServiceAPI.repository.JogadorRepository;

@RestController
@RequestMapping("/api")

public class JogadorController {

	@Autowired
	private JogadorRepository jogadorRepo;
	
	@GetMapping("/jogador")
	public List<JogadorDTO> getAllJogadores(){
		List<Jogador> listaJogador = jogadorRepo.findJogadoresDataConv();
		List<JogadorDTO> listaJogadorDTO = converteListaJogador(listaJogador);
		return listaJogadorDTO;
	}
	
	@GetMapping("/jogador/{codigo}")
	public ResponseEntity<JogadorDTO> getJogador(@PathVariable(value = "codigo") int codigo){
		Jogador jogador = jogadorRepo.findJogadorDataConv(codigo);
		JogadorDTO jogadorDTO = converteJogador(jogador);
		
		return ResponseEntity.ok().body(jogadorDTO);
	
	}

	@PostMapping("/jogador")
	public ResponseEntity<String> insertJogador(@Valid @RequestBody Jogador j){
		jogadorRepo.save(j);
		return ResponseEntity.ok().body("Jogador inserido com sucesso");
	}
	
	@PutMapping
	public ResponseEntity<String> updateJogador(@Valid @RequestBody Jogador j){
		jogadorRepo.save(j);
		return ResponseEntity.ok().body("Jogador atualizado com sucesso");
	}
	
	@DeleteMapping
	public ResponseEntity<String> deleteJogador(@Valid @RequestBody Jogador j){
		jogadorRepo.delete(j);
		return ResponseEntity.ok().body("Jogador deletado com sucesso");
	}
	
	private JogadorDTO converteJogador(Jogador j) {
		JogadorDTO jDto = new JogadorDTO();
		jDto.setCodigo(j.getCodigo());
		jDto.setAltura(j.getAltura());
		jDto.setDt_nasc(j.getDt_nasc());
		jDto.setSexo(j.getSexo());
		jDto.setNomeJogador(j.getNomeJogador());

		TimesDTO tDTO = new TimesDTO();
		tDTO.setId(jDto.getTimes().getId());
		tDTO.setNome(jDto.getTimes().getNome());
		tDTO.setCidade(jDto.getTimes().getCidade());
		
		jDto.setTimes(tDTO);
		
		
		
		return jDto;
	}

	private List<JogadorDTO> converteListaJogador(List<Jogador> listaJogador) {
		
		ArrayList<JogadorDTO> listaJodagorDTO = new ArrayList<JogadorDTO>();
		
		for(Jogador j : listaJogador) {
			JogadorDTO jDto = new JogadorDTO();
			jDto.setCodigo(j.getCodigo());
			jDto.setAltura(j.getAltura());
			jDto.setDt_nasc(j.getDt_nasc());
			jDto.setSexo(j.getSexo());
			jDto.setNomeJogador(j.getNomeJogador());

			TimesDTO tDTO = new TimesDTO();
			tDTO.setId(jDto.getTimes().getId());
			tDTO.setNome(jDto.getTimes().getNome());
			tDTO.setCidade(jDto.getTimes().getCidade());
			
			jDto.setTimes(tDTO);
			
			listaJodagorDTO.add(jDto);
		}
		return listaJodagorDTO;
	}
	
}
