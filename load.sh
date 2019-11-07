#!/usr/bin/env bash
SERVER_URL=${SERVER_URL:-http://elastic.docker.localhost}
FILE=${FILE:-./bjcp-es.json}

set -e
set -x

echo "### Drop index"
curl -XDELETE "$SERVER_URL/bjcp"

echo "### Create index with settings"
curl -f -XPUT -H "Content-Type: application/json" "$SERVER_URL/bjcp?pretty" --data-binary  @./settings.json

echo "### Set a mapping"
curl -f -XPUT -H "Content-Type: application/json" "$SERVER_URL/bjcp/_doc/_mapping" --data-binary  @./mappings.json

echo "### Bulk import"
curl -f -XPOST -H "Content-Type: application/json" "$SERVER_URL/bjcp/_doc/_bulk" --data-binary  @/tmp/a.json