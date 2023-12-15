CREATE USER "support";
GRANT USAGE ON SCHEMA "usaon-benefit-tool" TO "support";
GRANT SELECT, UPDATE ON ALL TABLES IN SCHEMA "usaon-benefit-tool" TO "support";
ALTER ROLE "support" IN DATABASE "usaon-benefit-tool" SET "search_path" TO "usaon-benefit-tool";
ALTER DEFAULT PRIVILEGES
  IN SCHEMA "usaon-benefit-tool"
    GRANT SELECT, UPDATE ON TABLES TO "support";
