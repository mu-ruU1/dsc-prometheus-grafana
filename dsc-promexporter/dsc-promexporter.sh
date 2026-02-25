#!/bin/bash -eu

SERVER=
NODE=

DSC_DIR=/var/lib/dsc
OUT_DIR=/var/lib/prometheus/node-exporter
OUT_FILE=$OUT_DIR/dsc.prom
LATEST=$(ls -1 $DSC_DIR/*.xml | tail -n 1)
TMP=$(mktemp "$OUT_DIR/dsc.prom.XXXXXX")
DATASETS="\
qtype,\
rcode,\
opcode,\
rcode_vs_replylen,\
client_subnet,\
qtype_vs_qnamelen,\
qtype_vs_tld,\
certain_qnames_vs_qtype,\
client_subnet2,\
client_addr_vs_rcode,\
chaos_types_and_names,\
country_code,\
asn_all,\
idn_qname,\
edns_version,\
edns_bufsiz,\
do_bit,\
rd_bit,\
idn_vs_tld,\
ipv6_rsn_abusers,\
transport_vs_qtype,\
client_port_range,\
second_ld_vs_rcode,\
third_ld_vs_rcode,\
direction_vs_ipproto,\
dns_ip_version_vs_qtype,\
response_time,\
label_count,\
qr_aa_bits"

cleanup() {
  rm -f "$TMP"
  find "$DSC_DIR" -name '*.xml' -mmin +60 -delete
}
trap cleanup EXIT

/usr/local/bin/dsc-datatool \
  -x "$LATEST" \
  -s "$SERVER" \
  -n "$NODE" \
  --dataset $DATASETS \
  -o ";Prometheus;timestamp=hide;prefix=dsc_" \
  > "$TMP"

install -m 0644 "$TMP" "$OUT_FILE"
