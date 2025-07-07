# Development Partnership Guide

## Development Partnership Principles

We are partners in creating production-quality code. Every line of code we write together should be:
- Maintainable by the next developer
- Thoroughly tested and documented
- Designed to catch issues early rather than hide them

## 🚨 MANDATORY AI WORKFLOW

***BEFORE DOING ANYTHING, YOU MUST:***

***ALWAYS use zen gemini*** for complex problems and architectural decisions

***ALWAYS check Context7*** for library documentation and best practices

***SAY THIS PHRASE***: "Let me research the codebase using zen gemini and Context7 to create a plan before implementing."

## Critical Workflow

***Research → Plan → Implement***

NEVER jump straight to coding. Always follow this sequence:

1. ***Research***: Use multiple agents to understand the codebase, existing patterns, and requirements
2. ***Plan***: Create a detailed implementation plan with TodoWrite
3. ***Implement***: Execute the plan with continuous validation

### Use Multiple Agents for Parallel Problem-Solving

When facing complex problems, launch multiple agents concurrently to:
- Research different aspects of the codebase
- Investigate various implementation approaches
- Validate assumptions and requirements

### Mandatory Automated Checks and Reality Checkpoints

Before any code is considered complete:
- Run all linters and formatters
- Execute all tests
- Validate the feature works end-to-end
- Clean up any old/unused code

## TypeScript/Next.js Specific Rules

### Forbidden Practices

- ***NO any or unknown types***: Always use specific types
- ***NO console.log in production***: Use proper logging
- ***NO inline styles***: Use Tailwind classes or CSS modules
- ***NO direct DOM manipulation***: Use React patterns

### Implementation Standards

Code is complete when:
- TypeScript compiler passes with strict mode
- ESLint passes with zero warnings
- All tests pass
- Next.js builds successfully
- Feature works end-to-end
- Old code is deleted
- JSDoc comments on all exported functions

## Project Structure Standards

### Next.js App Router Structure
```
app/
├── (auth)/          # Route groups
├── api/             # API routes
├── globals.css      # Global styles
├── layout.tsx       # Root layout
└── page.tsx         # Pages

components/
├── ui/              # Reusable UI components
├── forms/           # Form components
└── layout/          # Layout components

lib/
├── utils.ts         # Utility functions
├── types.ts         # Type definitions
└── validations.ts   # Zod schemas

hooks/               # Custom React hooks
```

### Component Patterns

- Use Radix UI primitives when available
- Follow shadcn/ui patterns for consistency
- Implement proper TypeScript interfaces
- Use React.forwardRef for reusable components
- Prefer composition over inheritance

## Testing Strategy

### When to Write Tests
- ***Complex business logic***: Write tests first (TDD)
- ***API routes***: Write integration tests
- ***Utility functions***: Write unit tests
- ***Components***: Write component tests for complex logic

### Testing Tools
```bash
# Run all tests
npm test

# Type checking
npm run type-check

# Linting
npm run lint

# Build verification
npm run build
```

## Communication Protocol

- Provide clear progress updates using TodoWrite
- Suggest improvements transparently
- Prioritize clarity over complexity
- Always explain the "why" behind architectural decisions

## Common Commands

```bash
# Development
npm run dev          # Start development server
npm run build        # Production build
npm run start        # Start production server
npm run lint         # Run ESLint
npm run type-check   # TypeScript checking

# Database (if using Prisma)
npx prisma generate  # Generate Prisma client
npx prisma db push   # Push schema changes
npx prisma studio    # Open Prisma Studio

# Strapi (if backend)
npm run develop      # Start Strapi dev server
npm run build        # Build Strapi admin
npm run start        # Start Strapi production
```

## Performance & Security

### Performance Standards
- Use Next.js Image component for all images
- Implement proper loading states
- Use React.memo for expensive components
- Optimize bundle size with dynamic imports
- Follow Web Vitals guidelines

### Security Standards
- Validate all inputs with Zod
- Use environment variables for secrets
- Implement proper authentication
- Sanitize user-generated content
- Use HTTPS in production

## Quality Gates

### Before Any Commit
1. TypeScript compiler passes ✅
2. ESLint passes with zero warnings ✅
3. All tests pass ✅
4. Build completes successfully ✅
5. Manual testing in development ✅

### Before Deployment
1. Production build works ✅
2. Environment variables configured ✅
3. Database migrations applied ✅
4. API endpoints tested ✅
5. Performance metrics acceptable ✅

## Architecture Principles

- **Single Responsibility**: Each component/function has one job
- **Dependency Injection**: Use context and hooks for dependencies
- **Type Safety**: Leverage TypeScript's type system fully
- **Error Boundaries**: Implement proper error handling
- **Accessibility**: Follow WCAG guidelines
- **Mobile First**: Design for mobile, enhance for desktop

## Common Patterns

### API Route Pattern
```typescript
import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'

const schema = z.object({
  // Define schema
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const data = schema.parse(body)
    
    // Process data
    
    return NextResponse.json({ success: true })
  } catch (error) {
    return NextResponse.json(
      { error: 'Invalid request' },
      { status: 400 }
    )
  }
}
```

### Component Pattern
```typescript
import { forwardRef } from 'react'
import { cn } from '@/lib/utils'

interface ComponentProps {
  // Define props
}

const Component = forwardRef<HTMLDivElement, ComponentProps>(
  ({ className, ...props }, ref) => {
    return (
      <div
        ref={ref}
        className={cn('base-classes', className)}
        {...props}
      />
    )
  }
)

Component.displayName = 'Component'

export { Component }
```

## Emergency Procedures

### When Hooks Fail
1. STOP immediately
2. Fix ALL reported issues
3. Verify the fix manually
4. Re-run the hook
5. Only continue when ✅ GREEN

### When Build Fails
1. Check TypeScript errors first
2. Verify all imports are correct
3. Check for missing dependencies
4. Validate environment variables
5. Clear .next cache if needed

Remember: This is production code - quality and reliability are paramount!