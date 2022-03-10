\copy openalex.authors (id, orcid, display_name, display_name_alternatives, works_count, cited_by_count, last_known_institution, works_api_url, updated_date) from program 'gunzip -c csv-files/authors.csv.gz' csv header
\copy openalex.works_referenced_works (work_id, referenced_work_id) from program 'gunzip -c csv-files/works_referenced_works.csv.gz' csv header
\copy openalex.works_related_works (work_id, related_work_id) from program 'gunzip -c csv-files/works_related_works.csv.gz' csv header
