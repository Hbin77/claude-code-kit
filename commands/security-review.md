Run a security audit on the current project or specified scope: $ARGUMENTS

## Steps

1. Launch the `security-reviewer` agent
2. Scan for OWASP Top 10 vulnerabilities
3. Check for hardcoded secrets, injection vulnerabilities, XSS
4. Review authentication and authorization patterns
5. Check dependency vulnerabilities (`npm audit` or equivalent)
6. Report findings by severity with remediation steps
