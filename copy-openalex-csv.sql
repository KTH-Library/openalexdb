--institutions

\copy openalex.institutions (id, ror, display_name, country_code, type, homepage_url, image_url, image_thumbnail_url, display_name_acroynyms, display_name_alternatives, works_count, cited_by_count, works_api_url, updated_date) from program 'gunzip -c csv-files/institutions.csv.gz' csv header
\copy openalex.institutions_ids (institution_id, openalex, ror, grid, wikipedia, wikidata, mag) from program 'gunzip -c csv-files/institutions_ids.csv.gz' csv header
\copy openalex.institutions_geo (institution_id, city, geonames_city_id, region, country_code, country, latitude, longitude) from program 'gunzip -c csv-files/institutions_geo.csv.gz' csv header
\copy openalex.institutions_associated_institutions (institution_id, associated_institution_id, relationship) from program 'gunzip -c csv-files/institutions_associated_institutions.csv.gz' csv header
\copy openalex.institutions_counts_by_year (institution_id, year, works_count, cited_by_count) from program 'gunzip -c csv-files/institutions_counts_by_year.csv.gz' csv header

--authors

\copy openalex.authors (id, orcid, display_name, display_name_alternatives, works_count, cited_by_count, last_known_institution, works_api_url, updated_date) from program 'gunzip -c csv-files/authors.csv.gz' csv header
\copy openalex.authors_ids (author_id, openalex, orcid, scopus, twitter, wikipedia, mag) from program 'gunzip -c csv-files/authors_ids.csv.gz' csv header
\copy openalex.authors_counts_by_year (author_id, year, works_count, cited_by_count) from program 'gunzip -c csv-files/authors_counts_by_year.csv.gz' csv header

--concepts

\copy openalex.concepts (id, wikidata, display_name, level, description, works_count, cited_by_count, image_url, image_thumbnail_url, works_api_url, updated_date) from program 'gunzip -c csv-files/concepts.csv.gz' csv header
\copy openalex.concepts_ancestors (concept_id, ancestor_id) from program 'gunzip -c csv-files/concepts_ancestors.csv.gz' csv header
\copy openalex.concepts_counts_by_year (concept_id, year, works_count, cited_by_count) from program 'gunzip -c csv-files/concepts_counts_by_year.csv.gz' csv header
\copy openalex.concepts_ids (concept_id, openalex, wikidata, wikipedia, umls_aui, umls_cui, mag) from program 'gunzip -c csv-files/concepts_ids.csv.gz' csv header
\copy openalex.concepts_related_concepts (concept_id, related_concept_id, score) from program 'gunzip -c csv-files/concepts_related_concepts.csv.gz' csv header

--venues

\copy openalex.venues (id, issn_l, issn, display_name, publisher, works_count, cited_by_count, is_oa, is_in_doaj, homepage_url, works_api_url, updated_date) from program 'gunzip -c csv-files/venues.csv.gz' csv header
\copy openalex.venues_ids (venue_id, openalex, issn_l, issn, mag) from program 'gunzip -c csv-files/venues_ids.csv.gz' csv header
\copy openalex.venues_counts_by_year (venue_id, year, works_count, cited_by_count) from program 'gunzip -c csv-files/venues_counts_by_year.csv.gz' csv header

--works
\copy openalex.works (id, doi, title, display_name, publication_year, publication_date, type, cited_by_count, is_retracted, is_paratext, cited_by_api_url, abstract_inverted_index) from program 'gunzip -c csv-files/works.csv.gz' csv header
\copy openalex.works_host_venues (work_id, venue_id, url, is_oa, version, license) from program 'gunzip -c csv-files/works_host_venues.csv.gz' csv header
\copy openalex.works_alternate_host_venues (work_id, venue_id, url, is_oa, version, license) from program 'gunzip -c csv-files/works_alternate_host_venues.csv.gz' csv header
\copy openalex.works_authorships (work_id, author_position, author_id, institution_id, raw_affiliation_string) from program 'gunzip -c csv-files/works_authorships.csv.gz' csv header
\copy openalex.works_biblio (work_id, volume, issue, first_page, last_page) from program 'gunzip -c csv-files/works_biblio.csv.gz' csv header
\copy openalex.works_concepts (work_id, concept_id, score) from program 'gunzip -c csv-files/works_concepts.csv.gz' csv header
\copy openalex.works_ids (work_id, openalex, doi, mag, pmid, pmcid) from program 'gunzip -c csv-files/works_ids.csv.gz' csv header
\copy openalex.works_mesh (work_id, descriptor_ui, descriptor_name, qualifier_ui, qualifier_name, is_major_topic) from program 'gunzip -c csv-files/works_mesh.csv.gz' csv header
\copy openalex.works_open_access (work_id, is_oa, oa_status, oa_url) from program 'gunzip -c csv-files/works_open_access.csv.gz' csv header
\copy openalex.works_referenced_works (work_id, referenced_work_id) from program 'gunzip -c csv-files/works_referenced_works.csv.gz' csv header
\copy openalex.works_related_works (work_id, related_work_id) from program 'gunzip -c csv-files/works_related_works.csv.gz' csv header
