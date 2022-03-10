# Postgres with pgadmin and pgloader

A quick example loading some data into postgres using pgloader.

## Introduction

Clone this repo and place a file a SQLite database such as oa.db (or bibmon.db) in the root directory.

Then start the services (pg, pgadmin) using `docker-compose up -d`.

Data will be migrated and loaded into postgres by pgloader.

Login to `pgadmin` using a web browser pointed to http://localhost, using credentials specified in the `docker-compose.yml` file.

Create a new connection against the "db" server, the "docker" database, for user "kthb" and using password "example".

## Using pgloader to load data from a SQLite database

Data from for example MSSQL, SQLite and text files can be loaded with [pgloader](https://manpages.ubuntu.com/manpages/bionic/man1/pgloader.1.html)

The Makefile has an example target for this:

		make migrate

Loading a sqlite db can look like this:

		Migrate a sqlite3 db into the postgres db
		# use connection URI postgresql://[user[:password]@][netloc][:port][/dbname][?schema.table]
		docker-compose run pgloader \
			pgloader /tmp/bibmon.db postgresql://kthb:example@db/db
		Starting openalexdb_db_1 ... done
		2022-02-10T18:14:20.000619Z LOG pgloader version "3.6.3~devel"
		2022-02-10T18:14:20.239321Z LOG Migrating from #<SQLITE-CONNECTION sqlite:///tmp/bibmon.db #x302001C981FD>
		2022-02-10T18:14:20.239658Z LOG Migrating into #<PGSQL-CONNECTION pgsql://kthb@db:5432/db #x302001C97B7D>
		2022-02-10T18:16:29.093616Z ERROR Database error 22P02: invalid input syntax for type real: "#<BOGUS object @ #x302006825BBD>"
		CONTEXT: COPY masterfile_researchers, line 58962, column swe_nuniv: "#<BOGUS object @ #x302006825BBD>"
		2022-02-10T18:18:27.169014Z LOG report summary reset
		               table name     errors       rows      bytes      total time
		-------------------------  ---------  ---------  ---------  --------------
		                    fetch          0          0                     0.000s
		          fetch meta data          0         53                     0.027s
		           Create Schemas          0          0                     0.000s
		         Create SQL Types          0          0                     0.000s
		            Create tables          0        106                     0.477s
		           Set Table OIDs          0         53                     0.003s
		-------------------------  ---------  ---------  ---------  --------------
		            t_cf_glidande          0      64476    15.4 MB          8.398s
		              glidande_sp          0      81685     3.4 MB          4.712s
		                   t_diva          0      62499    10.6 MB          7.113s
		          t_p_list_labels          0      62499    24.6 MB          7.199s
		            oa_status_new          0      32170    12.5 MB          4.549s
		               t_publ_cit          0      31878     6.7 MB          4.085s
		                 t_sampub          0      24576   837.4 kB          1.755s
		                     t_cf          0      20278     4.7 MB          2.466s
		       publ_res_frac_aggr          0      18106     1.1 MB          1.319s
		   jcf_glid_res_frac_aggr          0       6637   581.1 kB          0.969s
		      copub_glid_res_aggr          0       6631   367.9 kB          1.051s
		    cf_glid_res_frac_aggr          0       5090   538.7 kB          1.005s
		         c3_res_frac_aggr          0       4990   310.6 kB          0.987s
		      publ_dept_frac_aggr          0       1869   105.6 kB          0.828s
		    publ_school_frac_aggr          0        552    29.9 kB          0.783s
		     copub_glid_dept_aggr          0        173    13.0 kB          0.762s
		  jcf_glid_dept_frac_aggr          0        173    16.7 kB          0.800s
		        c3_dept_frac_aggr          0        171    12.3 kB          0.803s
		   cf_glid_dept_frac_aggr          0        144    19.1 kB          0.795s
		                r_top_trp          0        132     5.2 kB          0.787s
		           r_top_trp_frac          0        132     5.2 kB          0.809s
		      r_graph_topx_g_frac          0         96     4.2 kB          0.794s
		      r_graph_topx_g_full          0         96     4.2 kB          0.849s
		     r_graph_top10_g_frac          0         48     2.1 kB          0.801s
		     r_graph_top10_g_full          0         48     2.1 kB          0.821s
		            journal_full3          0         45     4.7 kB          0.797s
		               journal_w3          0         45     5.2 kB          0.819s
		      c3_school_frac_aggr          0         36     2.5 kB          0.812s
		   copub_glid_school_aggr          0         36     2.8 kB          0.812s
		jcf_glid_school_frac_aggr          0         36     3.4 kB          0.836s
		          journal_g_full3          0         36     4.0 kB          0.836s
		                     r_c3          0         33     1.8 kB          0.824s
		 cf_glid_school_frac_aggr          0         30     3.9 kB          0.948s
		          masterfile_full          0     152922    62.3 MB         18.151s
		       masterfile_2021jan          0     151160    61.1 MB         17.770s
		       masterfile_2019dec          0     147304    59.0 MB         15.205s
		                testtable          0          2     0.0 kB          0.660s
		       abm_copub_entities          0     782202    71.0 MB         50.736s
		               masterfile          0     663819   372.0 MB       1m40.685s
		          bestresaddr_kth          0     541536    95.3 MB         39.257s
		   masterfile_researchers          1          0                    19.695s
		                  log_run          0       1445    64.1 kB          0.692s
		             abm_org_info          0        105    45.6 kB          0.703s
		   indicator_descriptions          0         51     5.4 kB          1.067s
		               tmp_org_id          0         35    15.2 kB          0.892s
		   diva_publication_types          0         16     0.3 kB          0.857s
		        organization_type          0          9     0.3 kB          0.894s
		            analysis_info          0          3     0.2 kB          1.018s
		       masterfile_2019nov          0          0                     0.863s
		                  reports          0        194     2.2 GB        2m6.323s
		              researchers          0       3726   288.9 kB          1.072s
		                divisions          0        158    21.7 kB          0.819s
		               unit_stats          0        194    27.6 kB          0.746s
		-------------------------  ---------  ---------  ---------  --------------
		  COPY Threads Completion          0          4                   4m5.438s
		   Index Build Completion          0          0                     0.000s
		          Reset Sequences          0          0                     0.284s
		             Primary Keys          0          0                     0.000s
		      Create Foreign Keys          0          0                     0.000s
		          Create Triggers          0          0                     0.000s
		         Install Comments          0          0                     0.000s
		-------------------------  ---------  ---------  ---------  --------------
		        Total import time          1    2870327     3.0 GB        4m5.723s

This utility can also load data into postgres from text files.

# Loading an openalex subset into postgres

A "flattening script" can be run to convert JSON Lines into CSV files. This needs to be done first, see:

- https://gist.github.com/richard-orr/152d828356a7c47ed7e3e22d2253708d

Then there are are a couple of resources for loading data into a postgres db, with the openalex schema and a load script here:

- https://gist.github.com/richard-orr/4c30f52cf5481ac68dc0b282f46f1905 - This script is called `schema.sql` here
- https://gist.github.com/richard-orr/a1117d7dd618970a1af23fa4b54c4da4 - This script is called `copy-openalex-csv.sql` here

Also there is this repo which seems to use the MAG format(?):

- https://github.com/ourresearch/openalex-schema-test

## Resources in this repo

In this repo, a file `load.sql` is a subset of `copy-openalex-csv.sql`, and is created by running the `prepare_oa_subset.R` script

The `load.sql` and `schema.sql` can be run directly in the postgres dbshell (use `make dbshell`) using 

		\i schema.sql
		\i load.sql

However, it currently seems to complain on JSON fields... unlike when using pgloader and the `prepare_oa_subset.R`.

# Starting services using `docker-compose.yml`

Issue one command to start postgres db, the loader and a two SQL management tools (pgadmin4 and cloudbeaver) locally:

		docker-compose up -d
		
Then look at the `Makefile` for some ways of interacting with the services.

