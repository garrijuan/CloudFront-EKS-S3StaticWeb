package es.codeurjc.mastercloudapps.server.graphql;

import java.util.Collection;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.eclipse.microprofile.graphql.GraphQLApi;
import org.eclipse.microprofile.graphql.Id;
import org.eclipse.microprofile.graphql.Mutation;
import org.eclipse.microprofile.graphql.Query;

import es.codeurjc.mastercloudapps.server.model.EoloPlant;
import es.codeurjc.mastercloudapps.server.model.EoloPlantInput;
import es.codeurjc.mastercloudapps.server.service.EoloPlantCreatorService;
import es.codeurjc.mastercloudapps.server.service.EoloPlantService;

import java.util.logging.Logger;


@GraphQLApi
public class EoloPlantController {

	private static final Logger logger = Logger.getLogger(EoloPlantController.class.getName());

    @Inject
	EoloPlantService plants;

	@Query
	public Collection<EoloPlant> eoloPlants() {

		return plants.findAll();
	}

	@Query
	public EoloPlant eoloPlant(@Id long id) {
		logger.info("eoloPlant..EoloPlantController");
		return plants.findById(id).orElseThrow();
	}

	@Mutation
	@Transactional
	public EoloPlant createEoloPlant(EoloPlantInput eoloPlant) {
	logger.info("createEoloPlant..EoloPlantController");
		return plants.createEoloplant(eoloPlant);
	}

	@Mutation
	@Transactional
	public EoloPlant deleteEoloPlant(@Id long id) {
		logger.info("createEoloPlant..EoloPlantController");

		return plants.deleteById(id);
	}

}
