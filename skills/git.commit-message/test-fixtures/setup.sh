#!/bin/bash

# Setup script for git-commit-suggestion test fixtures
# Creates realistic git repositories with various change patterns

set -e

FIXTURES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Test case 1: Single feature change
echo "Setting up test case 1: Single feature (caching layer)..."
TEST1_DIR="$FIXTURES_DIR/test-case-1-single-feature"
rm -rf "$TEST1_DIR"
mkdir -p "$TEST1_DIR"
cd "$TEST1_DIR"

git init
git config user.email "test@example.com"
git config user.name "Test User"

# Create develop branch with base code
echo "// Base code" > main.ts
git add main.ts
git commit -m "initial commit"
git branch develop

# Create feature branch with caching
git checkout -b feature/caching
cat > cache.ts << 'EOF'
export class CacheLayer {
  private cache = new Map();

  get(key: string) {
    return this.cache.get(key);
  }

  set(key: string, value: any) {
    this.cache.set(key, value);
  }
}
EOF

git add cache.ts
git commit -m "WIP: caching feature"

# Modify main.ts to use cache
echo "// Base code with cache integration" > main.ts
git add main.ts
git commit -m "WIP: integrate cache"

echo "✓ Test case 1 created at $TEST1_DIR"

# Test case 2: Multi-type changes (docs + fix + test)
echo "Setting up test case 2: Multi-type changes..."
TEST2_DIR="$FIXTURES_DIR/test-case-2-multi-type"
rm -rf "$TEST2_DIR"
mkdir -p "$TEST2_DIR"
cd "$TEST2_DIR"

git init
git config user.email "test@example.com"
git config user.name "Test User"

# Create develop branch
echo "# Project" > README.md
git add README.md
git commit -m "initial commit"
git branch develop

# Create feature branch with multiple change types
git checkout -b feature/multi-changes

# Add documentation
cat > README.md << 'EOF'
# Project

## Authentication

The system uses JWT-based authentication.

### Configuration

Set the JWT_SECRET environment variable.
EOF

git add README.md
git commit -m "WIP: update docs"

# Fix a bug
cat > auth.ts << 'EOF'
export function verifyToken(token: string): boolean {
  // Fixed: was using wrong comparison operator
  return token.length > 0;
}
EOF

git add auth.ts
git commit -m "WIP: fix typo"

# Add tests
cat > auth.test.ts << 'EOF'
import { verifyToken } from './auth';

test('verifyToken returns true for valid tokens', () => {
  expect(verifyToken('valid-token')).toBe(true);
});
EOF

git add auth.test.ts
git commit -m "WIP: add tests"

echo "✓ Test case 2 created at $TEST2_DIR"

# Test case 3: ADR + Implementation
echo "Setting up test case 3: ADR + implementation..."
TEST3_DIR="$FIXTURES_DIR/test-case-3-adr-impl"
rm -rf "$TEST3_DIR"
mkdir -p "$TEST3_DIR"
cd "$TEST3_DIR"

git init
git config user.email "test@example.com"
git config user.name "Test User"

mkdir -p docs/adr
git add . 2>/dev/null || true
git commit -m "initial" 2>/dev/null || echo "initial commit skipped"
git branch develop 2>/dev/null || true

git checkout -b feature/mesh develop 2>/dev/null || git checkout -b feature/mesh

# Add ADR
cat > docs/adr/0001-service-mesh.md << 'EOF'
# ADR 0001: Service Mesh Strategy

## Status
Accepted

## Context
We need improved observability and traffic management across services.

## Decision
Adopt Istio for service mesh implementation.

## Consequences
- Improved observability with distributed tracing
- Enhanced traffic routing capabilities
- Additional operational complexity
EOF

git add docs/adr/0001-service-mesh.md

# Add implementation
mkdir -p infra
cat > infra/istio-config.yaml << 'EOF'
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: api
spec:
  hosts:
  - api
  http:
  - match:
    - uri:
        prefix: /v1
    route:
    - destination:
        host: api
        port:
          number: 8080
EOF

git add infra/istio-config.yaml
git commit -m "WIP: service mesh setup"

echo "✓ Test case 3 created at $TEST3_DIR"

echo ""
echo "All test fixtures created successfully!"
echo ""
echo "Test repositories:"
echo "  1. $TEST1_DIR"
echo "  2. $TEST2_DIR"
echo "  3. $TEST3_DIR"
echo ""
echo "To test: cd into each directory and run the skill"
