# Add Group OU
dn: ou=Groups{{with .Values.openLdap.domain | split "."}}{{range .}},dc={{.}}{{end}}{{end}}
changetype: add
objectclass: organizationalUnit
ou: Groups

# Add People OU
dn: ou=People{{with .Values.openLdap.domain | split "."}}{{range .}},dc={{.}}{{end}}{{end}}
changetype: add
objectclass: organizationalUnit
ou: People

# Add users
{{- $domain := .Values.openLdap.domain }}
{{- $initialPassword := .Values.openLdap.seedUsers.initialPassword }}
{{- with .Values.openLdap.seedUsers.userlist | split ","}}
  {{- range . }}
dn: uid={{.}},ou=People{{with $domain | split "."}}{{range .}},dc={{.}}{{end}}{{end}}
changetype: add
objectclass: inetOrgPerson
objectclass: organizationalPerson
objectclass: person
objectclass: top
uid: {{.}}
displayname: {{.}}
sn: {{.}}
cn: {{.}}
userpassword: {{ printf $initialPassword }}
{{ end }}
{{- end }}

# Create Cloud Pak user group
dn: cn={{.Values.openLdap.seedUsers.usergroup}},ou=Groups{{with .Values.openLdap.domain | split "."}}{{range .}},dc={{.}}{{end}}{{end}}
changetype: add
cn: {{.Values.openLdap.seedUsers.usergroup}}
objectclass: groupOfUniqueNames
objectclass: top
owner: cn=admin{{with .Values.openLdap.domain | split "."}}{{range .}},dc={{.}}{{end}}{{end}}
{{- with .Values.openLdap.seedUsers.userlist | split ","}}
  {{- range . }}
uniquemember: uid={{.}},ou=People{{with $domain | split "."}}{{range .}},dc={{.}}{{end}}{{end}}
  {{- end}}
{{- end}}
