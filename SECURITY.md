# Security Policy

## Supported versions

Security fixes are applied on the `main` branch.

## Reporting a vulnerability

Do not open a public issue for security-sensitive problems.

Use GitHub security advisories or contact the maintainer privately through GitHub with:

- a short description of the issue
- affected files or commands
- reproduction steps
- impact assessment
- any suggested fix or mitigation

## Scope

Please report issues such as:

- secret exposure or unsafe secret handling
- malicious or unsafe install behavior
- command injection, path traversal, or unsafe filesystem writes
- dependency or supply-chain risks in the bundled toolkit
- unsafe publication or registry metadata that could mislead users

## Handling secrets

- never commit `.env`
- never print `STITCH_API_KEY`
- treat generated `runs/` artifacts as potentially sensitive product material
