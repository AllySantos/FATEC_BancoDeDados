package com.edu.WebServiceAPI.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.WebServiceAPI.model.DTO.TimesDTO;
import com.edu.WebServiceAPI.model.entity.Times;
import com.edu.WebServiceAPI.repository.TimesRepository;

@RestController
@RequestMapping("/api")
public class TimeController {

	@Autowired	//injecao de dependencia
	private TimesRepository timesRep;
	
	@GetMapping("/times")
	public List<TimesDTO> getAllTimes(){
		List<Times> listaTimes = timesRep.findAll();
		List<TimesDTO> listaTimesDTO = converteListaTimes(listaTimes);
		
		return listaTimesDTO;
	}
	
	@GetMapping("/times/{idTime}")
	public ResponseEntity<TimesDTO> getTime(@PathVariable(value= "idTime") int  id) throws ResourceNotFoundException{
		Times time = timesRep.findById(null).orElseThrow(
					() -> new ResourceNotFoundException(id + " invalido")
				);
		
		TimesDTO tDto = converteTime(time);
		return ResponseEntity.ok().body(tDto);
	}
	
	@PostMapping("/times")
	public ResponseEntity<String> crudTimes(@Valid @RequestBody Times time){
		String saida = timesRep.spCrudTimes(time.getCod(), time.getId(), time.getNome(), time.getCidade());
	
		return ResponseEntity.ok().body(saida);
	}
	
	private TimesDTO converteTime(Times t) {
		TimesDTO tDto = new TimesDTO();
		tDto.setId(t.getId());
		tDto.setNome(t.getNome());
		tDto.setCidade(t.getCidade());
		
		return tDto;
	}
	
	private List<TimesDTO> converteListaTimes (List<Times> listaTimes){
		List<TimesDTO> listaTimesDTO = new ArrayList<TimesDTO>();
		
		for(Times t : listaTimes) {
			TimesDTO tDto = new TimesDTO();
			tDto.setId(t.getId());
			tDto.setNome(t.getNome());
			tDto.setCidade(t.getCidade());
			
			listaTimesDTO.add(tDto);
		}
		
		return listaTimesDTO;
		
	}
}
