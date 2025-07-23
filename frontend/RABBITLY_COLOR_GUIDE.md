# 🎨 Rabbitly Color System Guide

This guide provides a comprehensive overview of the Rabbitly color system, including usage guidelines, accessibility considerations, and implementation examples.

## 🎯 Color Philosophy

Rabbitly's color system is designed to:
- **Build Trust**: Professional blues and purples convey reliability
- **Encourage Learning**: Warm accents create an inviting environment
- **Ensure Accessibility**: High contrast ratios for all users
- **Maintain Consistency**: Unified color palette across all components

## 🌈 Color Palette

### Primary Brand Colors

| Color | Hex | Usage | CSS Variable |
|-------|-----|-------|--------------|
| Primary Blue | `#4A90E2` | Main brand color, CTAs, links | `var(--rabbitly-primary)` |
| Primary Dark | `#357abd` | Hover states, active elements | `var(--rabbitly-primary-dark)` |
| Primary Light | `#7BB3F0` | Backgrounds, highlights | `var(--rabbitly-primary-light)` |

### Secondary Brand Colors

| Color | Hex | Usage | CSS Variable |
|-------|-----|-------|--------------|
| Secondary Purple | `#7c3aed` | Accents, highlights | `var(--rabbitly-secondary)` |
| Secondary Dark | `#6d28d9` | Hover states | `var(--rabbitly-secondary-dark)` |
| Secondary Light | `#a78bfa` | Backgrounds, borders | `var(--rabbitly-secondary-light)` |

### Accent Colors

| Color | Hex | Usage | CSS Variable |
|-------|-----|-------|--------------|
| Success Green | `#10b981` | Success states, completed items | `var(--rabbitly-success)` |
| Warning Orange | `#f59e0b` | Warnings, attention | `var(--rabbitly-warning)` |
| Error Red | `#ef4444` | Errors, destructive actions | `var(--rabbitly-error)` |
| Info Blue | `#06b6d4` | Information, tips | `var(--rabbitly-info)` |

### Neutral Colors

| Color | Hex | Usage | CSS Variable |
|-------|-----|-------|--------------|
| Gray 50 | `#f8fafc` | Light backgrounds | `var(--rabbitly-gray-50)` |
| Gray 100 | `#f1f5f9` | Subtle backgrounds | `var(--rabbitly-gray-100)` |
| Gray 200 | `#e2e8f0` | Borders, dividers | `var(--rabbitly-gray-200)` |
| Gray 300 | `#cbd5e1` | Disabled states | `var(--rabbitly-gray-300)` |
| Gray 400 | `#94a3b8` | Placeholder text | `var(--rabbitly-gray-400)` |
| Gray 500 | `#64748b` | Secondary text | `var(--rabbitly-gray-500)` |
| Gray 600 | `#475569` | Body text | `var(--rabbitly-gray-600)` |
| Gray 700 | `#334155` | Headings | `var(--rabbitly-gray-700)` |
| Gray 800 | `#1e293b` | Dark backgrounds | `var(--rabbitly-gray-800)` |
| Gray 900 | `#0f172a` | Darkest backgrounds | `var(--rabbitly-gray-900)` |

## 🎨 Usage Guidelines

### Primary Actions
Use primary blue for main CTAs, important buttons, and key interactions:
```css
.primary-button {
  background-color: var(--rabbitly-primary);
  color: white;
}

.primary-button:hover {
  background-color: var(--rabbitly-primary-dark);
}
```

### Secondary Actions
Use secondary purple for secondary actions and accents:
```css
.secondary-button {
  background-color: var(--rabbitly-secondary);
  color: white;
}
```

### Success States
Use green for completed items, successful actions, and positive feedback:
```css
.success-badge {
  background-color: var(--rabbitly-success);
  color: white;
}
```

### Warning States
Use orange for warnings, attention-grabbing elements, and important notices:
```css
.warning-alert {
  background-color: var(--rabbitly-warning);
  color: white;
}
```

### Error States
Use red for errors, destructive actions, and critical issues:
```css
.error-message {
  color: var(--rabbitly-error);
}
```

### Information
Use info blue for tips, help text, and informational content:
```css
.info-box {
  background-color: var(--rabbitly-info);
  color: white;
}
```

## 🌟 Gradients

### Primary Gradient
```css
.gradient-primary {
  background: var(--rabbitly-gradient-primary);
}
```

### Secondary Gradient
```css
.gradient-secondary {
  background: var(--rabbitly-gradient-secondary);
}
```

### Hero Gradient
```css
.gradient-hero {
  background: var(--rabbitly-gradient-hero);
}
```

### Dark Gradient
```css
.gradient-dark {
  background: var(--rabbitly-gradient-dark);
}
```

## 🎭 Utility Classes

### Text Colors
```css
.text-primary    /* Primary blue text */
.text-secondary  /* Secondary purple text */
.text-success    /* Success green text */
.text-warning    /* Warning orange text */
.text-error      /* Error red text */
.text-info       /* Info blue text */
```

### Background Colors
```css
.bg-primary    /* Primary blue background */
.bg-secondary  /* Secondary purple background */
.bg-success    /* Success green background */
.bg-warning    /* Warning orange background */
.bg-error      /* Error red background */
.bg-info       /* Info blue background */
```

### Border Colors
```css
.border-primary    /* Primary blue border */
.border-secondary  /* Secondary purple border */
.border-success    /* Success green border */
.border-warning    /* Warning orange border */
.border-error      /* Error red border */
.border-info       /* Info blue border */
```

## 🎨 Component Examples

### Buttons
```css
/* Primary Button */
.btn-primary {
  background-color: var(--rabbitly-primary);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  transition: background-color 0.2s ease;
}

.btn-primary:hover {
  background-color: var(--rabbitly-primary-dark);
}

/* Secondary Button */
.btn-secondary {
  background-color: var(--rabbitly-secondary);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  transition: background-color 0.2s ease;
}

.btn-secondary:hover {
  background-color: var(--rabbitly-secondary-dark);
}
```

### Cards
```css
.card {
  background-color: var(--rabbitly-bg-primary);
  border: 1px solid var(--rabbitly-border-light);
  border-radius: 12px;
  box-shadow: 0 2px 10px var(--rabbitly-shadow-light);
  padding: 24px;
}
```

### Alerts
```css
.alert-success {
  background-color: var(--rabbitly-success);
  color: white;
  padding: 16px;
  border-radius: 8px;
  border-left: 4px solid var(--rabbitly-success-dark);
}

.alert-warning {
  background-color: var(--rabbitly-warning);
  color: white;
  padding: 16px;
  border-radius: 8px;
  border-left: 4px solid var(--rabbitly-warning-dark);
}

.alert-error {
  background-color: var(--rabbitly-error);
  color: white;
  padding: 16px;
  border-radius: 8px;
  border-left: 4px solid var(--rabbitly-error-dark);
}
```

## 🌙 Dark Mode Support

The color system automatically adapts to dark mode preferences:

```css
@media (prefers-color-scheme: dark) {
  :root {
    --rabbitly-bg-primary: #0f172a;
    --rabbitly-bg-secondary: #1e293b;
    --rabbitly-text-primary: #f8fafc;
    --rabbitly-text-secondary: #cbd5e1;
  }
}
```

## ♿ Accessibility

### Contrast Ratios
All color combinations meet WCAG AA standards:
- **Primary text**: 4.5:1 minimum contrast ratio
- **Large text**: 3:1 minimum contrast ratio
- **UI elements**: 3:1 minimum contrast ratio

### Color Blindness
- Avoid relying solely on color to convey information
- Use icons, patterns, and text labels alongside colors
- Test with color blindness simulators

### Focus States
```css
.focus-primary:focus {
  outline: 2px solid var(--rabbitly-primary);
  outline-offset: 2px;
}
```

## 🎯 Implementation Best Practices

### 1. Use CSS Variables
Always use CSS variables instead of hardcoded colors:
```css
/* ✅ Good */
.button {
  background-color: var(--rabbitly-primary);
}

/* ❌ Bad */
.button {
  background-color: #4A90E2;
}
```

### 2. Semantic Color Usage
Use colors based on their semantic meaning, not just appearance:
```css
/* ✅ Good - Success state */
.completed-item {
  color: var(--rabbitly-success);
}

/* ❌ Bad - Just because it's green */
.completed-item {
  color: #10b981;
}
```

### 3. Consistent Spacing
Use the provided utility classes for consistent styling:
```css
/* ✅ Good */
.card {
  background-color: var(--rabbitly-bg-primary);
  border: 1px solid var(--rabbitly-border-light);
  box-shadow: 0 4px 20px var(--rabbitly-shadow-medium);
}
```

### 4. Hover States
Always provide hover states for interactive elements:
```css
.button {
  background-color: var(--rabbitly-primary);
  transition: background-color 0.2s ease;
}

.button:hover {
  background-color: var(--rabbitly-primary-dark);
}
```

## 🔧 Migration Guide

### From Legacy Colors
If you're updating existing components:

```css
/* Old */
background-color: #B78AF0;

/* New */
background-color: var(--rabbitly-accent);
```

### From Hardcoded Colors
```css
/* Old */
color: #4A90E2;

/* New */
color: var(--rabbitly-primary);
```

## 📱 Responsive Considerations

### Mobile
- Ensure touch targets have sufficient contrast
- Use larger color blocks for better visibility
- Test color combinations on small screens

### High DPI Displays
- Colors render consistently across different pixel densities
- No special considerations needed for Retina displays

## 🧪 Testing

### Color Contrast Testing
Use tools like:
- WebAIM Contrast Checker
- Chrome DevTools Accessibility Audit
- axe-core accessibility testing

### Color Blindness Testing
- Chrome DevTools Color Blindness Simulation
- Online color blindness simulators
- Manual testing with color blind users

## 📚 Resources

- [WCAG Color Contrast Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)
- [Color Blindness Simulator](https://www.toptal.com/designers/colorfilter)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)

---

*This color system is designed to evolve with your brand. When updating colors, ensure all components are updated consistently and accessibility standards are maintained.* 