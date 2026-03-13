# Frontend Task Template

**Work Item Type:** Task
**Title:** [Feature Name] - Frontend Implementation
**Parent:** [Link to parent User Story]

### Objective

[One clear sentence: What UI/functionality this task delivers to users]

### Requirements

- **User Interface:** [What the user needs to see and interact with]
- **Data Display:** [What data needs to be shown to users]
- **User Interactions:** [What actions users need to perform]
- **Form Inputs:** [What data users need to input, if applicable]
- **Validation:** [What validation rules apply to user input]
- **Error Handling:** [How errors should be communicated to users]
- **Similar Features:** [Reference existing UI components or pages developers can examine]

> **Note:** This task requires UI design/mockup. Consider using sub-agent for mockup generation or create wireframes before implementation.

## UI Design Considerations

**Mockup should show:**

- [Key UI element placement and layout]
- [Label text and styling details]
- [Consistency with existing UI patterns]
- [Required field indicators, if applicable]
- [Error message placement and styling]
- [How data displays in different states (loading, success, error, read-only)]

> **Note:** See separate `ESTIMATES-[feature].md` file for effort estimates

---

## Usage Guidelines

### Frontend Tasks Should Focus On 👁️

- **User Experience:** What users see and how they interact
- **Data Presentation:** How information is displayed
- **User Workflows:** Step-by-step user interactions
- **Validation & Feedback:** What happens when users make mistakes
- **Responsive Design:** How UI adapts to different screen sizes
- **Accessibility:** How users with disabilities interact with the feature

### What to Include ✅

- Description of UI elements (buttons, forms, tables, etc.)
- User interaction flows
- Data that needs to be displayed
- Input fields and their validation rules
- Error states and messages
- Success states and confirmation messages
- Reference to similar existing features

### What to Avoid ❌

- Specific React component implementations
- State management details (Redux slices, hooks, etc.)
- CSS framework choices
- Build tool configurations
- Specific testing frameworks

### Mockup/Wireframe Note 🎨

Frontend tasks **require visual guidance**. Before implementation begins:

1. Create wireframes or mockups (low/high fidelity)
2. Consider using a sub-agent to generate mockup suggestions
3. Get stakeholder approval on UI design
4. Attach mockups to the task in ADO

**Future Enhancement:** Sub-agent mockup generation will be integrated into the workflow.

**Remember:** Describe what users need to do and see, let developers decide how to build it!
