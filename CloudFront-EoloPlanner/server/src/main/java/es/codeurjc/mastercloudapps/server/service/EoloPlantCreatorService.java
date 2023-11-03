package es.codeurjc.mastercloudapps.server.service;

import es.codeurjc.mastercloudapps.server.model.EoloPlantCreationRequest;
import es.codeurjc.mastercloudapps.server.model.EoloPlantInput;

import java.util.logging.Logger;

import javax.enterprise.context.ApplicationScoped;

import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.logging.Logger;

@ApplicationScoped
public class EoloPlantCreatorService {

    @Channel("eoloplantCreationRequests")
    Emitter<EoloPlantCreationRequest> emitter;

    private static final Logger logger = Logger.getLogger(EoloPlantCreatorService.class.getName());


    public void createEoloPlant(EoloPlantCreationRequest eoloPlantCreationRequest) {
      logger.info("createEoloPlant..EoloPlantCreatorService");
		emitter.send(eoloPlantCreationRequest);
    }
    
    public String jsonify(EoloPlantInput request) throws JsonProcessingException {
      logger.info("jsonify..EoloPlantCreatorService");
    	ObjectMapper mapper = new ObjectMapper();
    	return mapper.writeValueAsString(request);
    }

}
