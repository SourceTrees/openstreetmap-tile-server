CREATE INDEX idx_poly_idlanduse ON  planet_osm_polygon USING gist (way)
       WHERE((landuse IS NOT NULL)
               OR (leisure IS NOT NULL)
               OR (aeroway = ANY ('{apron,aerodrome}'::text[]))
               OR (amenity = ANY ('{parking,university,college,school,hospital,kindergarten,grave_yard}'::text[]))
               OR (military = ANY ('{barracks,danger_area}'::text[]))
               OR ("natural" = ANY ('{field,beach,desert,heath,mud,grassland,wood,sand,scrub}'::text[]))
               OR (power = ANY ('{station,sub_station,generator}'::text[]))
               OR (tourism = ANY ('{attraction,camp_site,caravan_site,picnic_site,zoo}'::text[]))
               OR (highway = ANY ('{services,rest_area}'::text[])));

CREATE INDEX idx_poly_text_poly ON planet_osm_polygon USING gist (way)
       where amenity is not null
                 or shop in ('supermarket','bakery','clothes','fashion','convenience','doityourself','hairdresser','department_store', 'butcher','car','car_repair','bicycle')
                 or leisure is not null
                 or landuse is not null
                 or tourism is not null
                 or "natural" is not null
                 or man_made in ('lighthouse','windmill')
                 or place='island'
                 or military='danger_area'
                 or historic in ('memorial','archaeological_site')
                 or highway='bus_stop';

CREATE INDEX "idx_line_cutline" on planet_osm_line  USING gist (way)
       where man_made='cutline';

CREATE INDEX idx_poly_buildings_lz ON planet_osm_polygon USING gist (way)
       where railway='station'
         or building in ('station','supermarket')
         or amenity='place_of_worship';

/* this index takes longer to build, but improves query time from 18.532ms to 1.0745ms */
/* CREATE INDEX idx_poly_buildings ON planet_osm_polygon USING gist (way)
       where (building is not null
                and building not in ('no','station','supermarket','planned')
                and (railway is null or railway != 'station')
                and (amenity is null or amenity != 'place_of_worship'))
                 or aeroway = 'terminal'; */

/* CREATE INDEX water_areas_idx ON planet_osm_polygon USING gist (way)
       WHERE (((waterway IS NOT NULL)
       OR (landuse = ANY (ARRAY['reservoir'::text, 'water'::text, 'basin'::text])))
       OR ("natural" IS NOT NULL)); */
