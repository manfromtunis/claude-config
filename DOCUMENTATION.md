# Claude Code Configuration Documentation

## Overview

This configuration transforms Claude Code into a powerful development assistant for TypeScript/Next.js/Strapi projects with automated quality gates and AI-powered research capabilities.

## Core Components

### 1. MCP Servers

#### Context7
- **Purpose**: Library documentation and best practices lookup
- **Installation**: `npm install -g @upstash/context7-mcp`
- **API Key**: None required
- **Usage**: Automatically provides context about libraries and frameworks

#### Zen MCP Server
- **Purpose**: AI-powered architectural decisions and complex problem solving
- **Installation**: Git clone + environment setup
- **API Key**: Gemini API key required (recommended: paid for Gemini 2.5 Pro)
- **Usage**: Complex reasoning and code analysis

### 2. CLAUDE.md Configuration

#### Mandatory AI Workflow
Every development session MUST start with:
> "Let me research the codebase using zen gemini and Context7 to create a plan before implementing."

This ensures:
- ✅ Proper codebase understanding
- ✅ Architecture-aware decisions
- ✅ Library best practices
- ✅ Comprehensive planning

#### Development Workflow
1. **Research Phase**
   - Use Context7 for documentation
   - Use Zen Gemini for architectural analysis
   - Understand existing patterns
   - Identify dependencies

2. **Plan Phase**
   - Create detailed implementation plan
   - Use TodoWrite for task tracking
   - Verify approach with AI assistance
   - Consider edge cases

3. **Implement Phase**
   - Follow the plan strictly
   - Continuous validation
   - Quality gates at checkpoints
   - Document as you go

### 3. Hook System

#### Pre-Commit Hook
**Triggers**: Before every commit
**Checks**:
- ESLint validation (must pass)
- TypeScript compilation (must pass)
- Basic test suite (warns if fails)

**Failure Action**: Blocks commit until fixed

#### Pre-Push Hook
**Triggers**: Before pushing to remote
**Checks**:
- Full production build (must pass)
- Complete test suite (warns if fails)
- Security audit (warns if vulnerabilities)

**Failure Action**: Blocks push until fixed

#### Post-Checkout Hook
**Triggers**: After switching branches
**Actions**:
- Detects dependency changes
- Auto-installs updated packages
- Prepares development environment

## Usage Patterns

### Starting a New Feature

1. **Research First**
```bash
# Say the mandatory phrase
"Let me research the codebase using zen gemini and Context7 to create a plan before implementing."
```

2. **Understand Context**
- Examine existing similar features
- Check component patterns
- Understand data flow
- Identify integration points

3. **Create Plan**
- Break down into small tasks
- Identify potential challenges
- Plan testing strategy
- Consider performance implications

4. **Implement Incrementally**
- Complete one task at a time
- Test each component
- Validate integration
- Update documentation

### Working with TypeScript

#### Type Safety
```typescript
// ❌ Avoid
const data: any = await fetchData()

// ✅ Prefer
interface ApiResponse {
  id: string
  name: string
  status: 'active' | 'inactive'
}
const data: ApiResponse = await fetchData()
```

#### Component Patterns
```typescript
// ✅ Standard component pattern
interface ButtonProps {
  variant?: 'primary' | 'secondary'
  size?: 'sm' | 'md' | 'lg'
  children: React.ReactNode
}

const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ variant = 'primary', size = 'md', children, ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={cn(buttonVariants({ variant, size }))}
        {...props}
      >
        {children}
      </button>
    )
  }
)
```

### Working with Next.js

#### App Router Structure
```
app/
├── (auth)/           # Route groups for layout isolation
│   ├── login/
│   └── register/
├── api/              # API routes
│   ├── auth/
│   └── users/
├── dashboard/        # Protected routes
│   ├── settings/
│   └── profile/
├── globals.css       # Global styles
├── layout.tsx        # Root layout
└── page.tsx          # Home page
```

#### API Route Pattern
```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'

const createUserSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { name, email } = createUserSchema.parse(body)
    
    // Business logic here
    const user = await createUser({ name, email })
    
    return NextResponse.json({ user })
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Validation failed', details: error.errors },
        { status: 400 }
      )
    }
    
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
```

### Quality Gates

#### TypeScript Strict Mode
```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

#### ESLint Configuration
```json
// .eslintrc.json
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "error",
    "prefer-const": "error"
  }
}
```

## Troubleshooting

### Hook Failures

#### ESLint Errors
```bash
# Fix automatically where possible
npm run lint -- --fix

# Check specific file
npx eslint src/components/Button.tsx
```

#### TypeScript Errors
```bash
# Check types
npm run type-check

# Or directly
npx tsc --noEmit
```

#### Build Failures
```bash
# Clear Next.js cache
rm -rf .next

# Clear node_modules if needed
rm -rf node_modules package-lock.json
npm install

# Rebuild
npm run build
```

### MCP Server Issues

#### Context7 Not Working
```bash
# Reinstall globally
npm uninstall -g @upstash/context7-mcp
npm install -g @upstash/context7-mcp

# Check status
npx @upstash/context7-mcp --help
```

#### Zen Server Issues
```bash
# Check environment
cd zen-mcp-server
cat .env  # Verify API keys are set

# Test server
./run-server.sh

# Check logs
tail -f logs/server.log
```

### API Key Management

#### Getting Gemini API Key
1. Visit [Google AI Studio](https://aistudio.google.com/)
2. Create new project or select existing
3. Navigate to "API Keys" section
4. Click "Create API Key"
5. Copy key to zen-mcp-server/.env

#### Testing API Key
```bash
cd zen-mcp-server
export GEMINI_API_KEY="your-key-here"
python test_api.py  # If available
```

## Best Practices

### Code Organization

#### Component Structure
```
components/
├── ui/              # Basic UI primitives
│   ├── Button.tsx
│   ├── Input.tsx
│   └── index.ts
├── forms/           # Form-specific components
│   ├── LoginForm.tsx
│   └── ContactForm.tsx
├── layout/          # Layout components
│   ├── Header.tsx
│   ├── Footer.tsx
│   └── Sidebar.tsx
└── features/        # Feature-specific components
    ├── auth/
    ├── dashboard/
    └── settings/
```

#### Type Organization
```typescript
// lib/types.ts
export interface User {
  id: string
  name: string
  email: string
  role: 'admin' | 'user'
}

export interface Campaign {
  id: string
  name: string
  status: 'active' | 'inactive'
  advertiser: User
}

// Use branded types for IDs
export type UserId = string & { __brand: 'UserId' }
export type CampaignId = string & { __brand: 'CampaignId' }
```

### Performance Optimization

#### Image Optimization
```typescript
import Image from 'next/image'

// ✅ Optimized
<Image
  src="/hero-image.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,..."
/>
```

#### Dynamic Imports
```typescript
// ✅ Code splitting
const DashboardChart = dynamic(() => import('./DashboardChart'), {
  ssr: false,
  loading: () => <ChartSkeleton />
})
```

### Security Practices

#### Input Validation
```typescript
import { z } from 'zod'

// ✅ Always validate inputs
const userSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
  password: z.string().min(8).regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/)
})

export function validateUser(data: unknown) {
  return userSchema.parse(data)
}
```

#### Environment Variables
```typescript
// ✅ Validate environment variables
const envSchema = z.object({
  DATABASE_URL: z.string().url(),
  JWT_SECRET: z.string().min(32),
  NEXT_PUBLIC_API_URL: z.string().url(),
})

export const env = envSchema.parse(process.env)
```

## Advanced Usage

### Custom Hooks Integration

You can extend the hook system for project-specific needs:

```bash
# Create custom hook
cat > ~/.config/claude-code/hooks/pre-commit-custom << 'EOF'
#!/bin/bash
# Custom project-specific checks
if [ -f "prisma/schema.prisma" ]; then
  npx prisma generate
  echo "✅ Prisma client regenerated"
fi
EOF

chmod +x ~/.config/claude-code/hooks/pre-commit-custom
```

### Team Configuration

For team consistency, version control the CLAUDE.md:

```bash
# In your project repository
cp ~/.config/claude-config/CLAUDE.md .
git add CLAUDE.md
git commit -m "Add Claude Code configuration"
```

## Summary

This configuration provides:
- **Automated Quality Gates**: No broken code reaches production
- **AI-Powered Development**: Context7 + Zen for intelligent assistance
- **Consistent Workflows**: Standardized development patterns
- **Type Safety**: Comprehensive TypeScript integration
- **Performance Focus**: Built-in optimization practices

Remember: Always start with the mandatory phrase and follow the Research → Plan → Implement workflow!