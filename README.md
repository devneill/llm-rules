# Cursor Rule Templates

A collection of rule templates for [Cursor](https://cursor.sh/) to enhance your development experience across different stacks and projects.

Using a rule set like this avoids your LLM using the wrong tools, the wrong project structure and the wrong coding patterns. 

The rule set provides your LLM with the full context of your project from the start, which leads to less wasted time from bug loops and rabbit holes. 

Have a plan, share it your LLM, and stay on track.

## Available Templates

- **Epic Stack Rules** (`epic-stack-rules.mdc`) - Rule template for projects using [Kent C. Dodds' Epic Stack](https://github.com/epicweb-dev/epic-stack), a comprehensive full-stack JavaScript framework.

## How to Use These Templates

1. **Copy the desired rule template** to your project's `.cursor/rules/` directory.

2. **Customize the template**. 
- Update the _Product Vision_ and _Core features_ to describe your project
- Update _Technical Implementation_ to describe the technical details of your features. 
- Update your _Roadmap_ with the status of your project as you progress.

## How It Works

Cursor's AI uses the information in these rule files to better understand your project's context, requirements, and structure. This enables more accurate code suggestions and completions tailored to your specific project.

The rule files typically contain:
- Roadmap - your project's current status
- Core Features - what you are going to build
- Technical Implementation - the technical details of how to implement your features 
- Implmentation Plan - the steps to follow to implement your features
- Technical Information - your stack, established patterns and code style

## Contributing

Contributions are welcome! If you have rule templates for other stacks or frameworks, please consider sharing them:

1. Fork this repository
2. Add your rule template (use the naming convention `[stack-name]-rules.mdc`)
3. Update this README to include information about your template
4. Submit a pull request