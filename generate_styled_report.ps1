param(
  [string]$OutputPath = "E:\Angular\customer-csv-app\Customer_CSV_App_Internship_Report_Styled_v2.docx"
)

Set-Location "E:\Angular\customer-csv-app"
$outPath = $OutputPath

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()

$doc.PageSetup.TopMargin = $word.CentimetersToPoints(2.54)
$doc.PageSetup.BottomMargin = $word.CentimetersToPoints(2.54)
$doc.PageSetup.LeftMargin = $word.CentimetersToPoints(2.54)
$doc.PageSetup.RightMargin = $word.CentimetersToPoints(2.54)

$normal = $doc.Styles.Item("Normal")
$normal.Font.Name = "Times New Roman"
$normal.Font.Size = 12
$normal.ParagraphFormat.LineSpacingRule = 4
$normal.ParagraphFormat.LineSpacing = 15
$normal.ParagraphFormat.SpaceAfter = 8
$normal.ParagraphFormat.Alignment = 3

$h1 = $doc.Styles.Item("Heading 1")
$h1.Font.Name = "Cambria"
$h1.Font.Size = 18
$h1.Font.Bold = $true
$h1.ParagraphFormat.SpaceBefore = 12
$h1.ParagraphFormat.SpaceAfter = 10

$h2 = $doc.Styles.Item("Heading 2")
$h2.Font.Name = "Cambria"
$h2.Font.Size = 14
$h2.Font.Bold = $true
$h2.ParagraphFormat.SpaceBefore = 10
$h2.ParagraphFormat.SpaceAfter = 8

$h3 = $doc.Styles.Item("Heading 3")
$h3.Font.Name = "Cambria"
$h3.Font.Size = 12
$h3.Font.Bold = $true
$h3.ParagraphFormat.SpaceBefore = 8
$h3.ParagraphFormat.SpaceAfter = 6

function Add-Heading($text, $level) {
  $p = $doc.Paragraphs.Add()
  $p.Range.Text = $text
  if ($level -eq 1) { $p.Range.Style = "Heading 1" }
  elseif ($level -eq 2) { $p.Range.Style = "Heading 2" }
  else { $p.Range.Style = "Heading 3" }
  $p.Range.InsertParagraphAfter() | Out-Null
}

function Add-Para($text) {
  $p = $doc.Paragraphs.Add()
  $p.Range.Text = $text
  $p.Range.Style = "Normal"
  $p.Range.InsertParagraphAfter() | Out-Null
}

function Add-Bullets($items) {
  foreach ($item in $items) {
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = $item
    $p.Range.Style = "Normal"
    $p.Range.ListFormat.ApplyBulletDefault() | Out-Null
    $p.Range.InsertParagraphAfter() | Out-Null
  }
}

function Add-Code($lines) {
  foreach ($line in $lines) {
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = $line
    $p.Range.Style = "Normal"
    $p.Range.Font.Name = "Consolas"
    $p.Range.Font.Size = 10
    $p.Range.ParagraphFormat.Alignment = 0
    $p.Range.ParagraphFormat.LeftIndent = $word.CentimetersToPoints(0.8)
    $p.Range.ParagraphFormat.SpaceAfter = 2
    $p.Range.InsertParagraphAfter() | Out-Null
  }
  Add-Para ""
}

$cp = $doc.Paragraphs.Add()
$cp.Range.Text = "INTERNSHIP PROJECT REPORT"
$cp.Range.Style = "Heading 1"
$cp.Range.ParagraphFormat.Alignment = 1
$cp.Range.Font.Size = 24
$cp.Range.InsertParagraphAfter() | Out-Null

$p = $doc.Paragraphs.Add()
$p.Range.Text = "Customer CSV Management Dashboard"
$p.Range.Style = "Heading 2"
$p.Range.ParagraphFormat.Alignment = 1
$p.Range.Font.Size = 18
$p.Range.InsertParagraphAfter() | Out-Null

Add-Para ""
$p = $doc.Paragraphs.Add(); $p.Range.Text = "Internship Type: Individual"; $p.Range.ParagraphFormat.Alignment = 1; $p.Range.InsertParagraphAfter() | Out-Null
$p = $doc.Paragraphs.Add(); $p.Range.Text = "Technology: Angular 12, TypeScript, HTML, CSS, PapaParse, LocalStorage"; $p.Range.ParagraphFormat.Alignment = 1; $p.Range.InsertParagraphAfter() | Out-Null
$p = $doc.Paragraphs.Add(); $p.Range.Text = "Date: March 13, 2026"; $p.Range.ParagraphFormat.Alignment = 1; $p.Range.InsertParagraphAfter() | Out-Null

$doc.Paragraphs.Add().Range.InsertBreak(7) | Out-Null

Add-Heading "Table of Contents" 1
$range = $doc.Paragraphs.Add().Range
$null = $doc.TablesOfContents.Add($range, $true, 1, 3)
$doc.Paragraphs.Add().Range.InsertBreak(7) | Out-Null

Add-Heading "1. Project Approach" 1
Add-Para "This project was developed using a phased approach to ensure each module was completed, tested, and integrated in a controlled way."
Add-Bullets @(
"Requirement understanding and user-flow definition.",
"Angular project setup with routing and modular folder structure.",
"Authentication implementation using signup and login screens.",
"CSV upload and parsing using PapaParse.",
"Centralized data handling with CustomerService.",
"Dashboard analytics, table rendering, and row navigation.",
"Single filter flow implementation (filter type + filter value) along with search.",
"Customer details page and final UI improvements."
)
Add-Para "Approach snapshot in code flow:"
Add-Code @(
"const users = localStorage.getItem('users');",
"Papa.parse(file, { header: true, complete: onParsed });",
"customerService.setCustomers(parsedRows);",
"router.navigate(['/dashboard']);"
)

Add-Heading "2. System Flow Diagram" 1
Add-Para "The following process flow summarizes the complete working of the application:"
Add-Bullets @(
"Start Application -> Login Page",
"New User -> Signup -> Save credentials -> Return to Login",
"Valid Login -> Upload CSV Page",
"Upload/Drag CSV -> Parse using PapaParse -> Store in CustomerService",
"Navigate to Dashboard -> View metrics and customer table",
"Apply Search + Single Filter (Type then Value)",
"Open Customer Details from selected row",
"Back to Dashboard"
)
Add-Para "Compact flow representation:"
Add-Para "START -> LOGIN -> (SIGNUP if needed) -> UPLOAD CSV -> PARSE -> STORE DATA -> DASHBOARD -> SEARCH/FILTER -> CUSTOMER DETAILS -> BACK -> END"

Add-Heading "3. Folder Structure" 1
Add-Heading "3.1 Components" 2
Add-Bullets @(
"login: Validates user credentials and controls initial access.",
"signup: Creates account and stores credentials in LocalStorage.",
"upload: Accepts CSV file, parses records, and routes to dashboard.",
"dashboard: Shows metrics, table, and unified filtering.",
"customer-details: Displays complete information of selected customer."
)

Add-Heading "3.2 Models" 2
Add-Bullets @(
"customer.model.ts: Defines the Customer interface used across the application."
)
Add-Para "Model code snippet:"
Add-Code @(
"export interface Customer {",
"  Name: string;",
"  phno: string;",
"  'Registration No': string;",
"  'Due Date': string;",
"  Model: string;",
"}"
)

Add-Heading "3.3 Services" 2
Add-Bullets @(
"customer.service.ts: Stores uploaded customer data and provides access methods."
)
Add-Para "Service code snippet:"
Add-Code @(
"customers: Customer[] = [];",
"setCustomers(data: Customer[]) { this.customers = data; }",
"getCustomer() { return this.customers; }"
)

Add-Heading "4. Component-Wise Explanation" 1
Add-Heading "4.1 Login Component" 2
Add-Para "Captures email and password, checks credentials from LocalStorage, and redirects valid users to the upload module."
Add-Para "Login code snippet:"
Add-Code @(
"const users = JSON.parse(localStorage.getItem('users') || '[]');",
"const user = users.find((u: any) => u.email === this.email && u.password === this.password);",
"if (user) this.router.navigate(['/upload']);"
)

Add-Heading "4.2 Signup Component" 2
Add-Para "Registers new users by saving credentials in LocalStorage and redirects back to login."
Add-Para "Signup code snippet:"
Add-Code @(
"const users = JSON.parse(localStorage.getItem('users') || '[]');",
"users.push({ email: this.email, password: this.password });",
"localStorage.setItem('users', JSON.stringify(users));"
)

Add-Heading "4.3 Upload Component" 2
Add-Para "Handles CSV selection and drag-drop upload. Uses PapaParse with header mode and skip-empty-lines to create customer records and save them via CustomerService."
Add-Para "Upload code snippet:"
Add-Code @(
"Papa.parse(this.selectedFile, {",
"  header: true,",
"  skipEmptyLines: true,",
"  complete: (result) => this.customerService.setCustomers(result.data)",
"});"
)

Add-Heading "4.4 Dashboard Component" 2
Add-Para "Loads records from service, calculates total customers/models/due-soon count, and renders the customer table."
Add-Bullets @(
"Search by Name, Phone, or Registration Number.",
"Single filter mode: first choose filter type (All/Model/Due Date), then choose value.",
"Combined filtering ensures reliable and predictable results."
)
Add-Para "Dashboard filter code snippet:"
Add-Code @(
"if (this.selectedFilterType === 'model') {",
"  matchesTypeFilter = this.selectedFilterValue === 'All' || c.Model === this.selectedFilterValue;",
"} else if (this.selectedFilterType === 'due') {",
"  matchesTypeFilter = this.selectedFilterValue === 'overdue' ? due < today : true;",
"}"
)

Add-Heading "4.5 Customer Details Component" 2
Add-Para "Reads selected customer through route parameter and displays full profile details with back navigation support."
Add-Para "Customer details code snippet:"
Add-Code @(
"const id = this.route.snapshot.params['id'];",
"const customers = this.customerService.getCustomer();",
"this.customer = customers[id];"
)

Add-Heading "5. Routing Summary" 1
$tblR = $doc.Tables.Add($doc.Paragraphs.Add().Range, 6, 2)
$tblR.Borders.Enable = 1
$tblR.Cell(1,1).Range.Text = "Route"
$tblR.Cell(1,2).Range.Text = "Component"
$tblR.Cell(2,1).Range.Text = "/"
$tblR.Cell(2,2).Range.Text = "Login"
$tblR.Cell(3,1).Range.Text = "/signup"
$tblR.Cell(3,2).Range.Text = "Signup"
$tblR.Cell(4,1).Range.Text = "/upload"
$tblR.Cell(4,2).Range.Text = "Upload"
$tblR.Cell(5,1).Range.Text = "/dashboard"
$tblR.Cell(5,2).Range.Text = "Dashboard"
$tblR.Cell(6,1).Range.Text = "/customer/:id"
$tblR.Cell(6,2).Range.Text = "Customer Details"
$doc.Paragraphs.Add().Range.InsertParagraphAfter() | Out-Null
Add-Para "Routing code snippet:"
Add-Code @(
"const routes: Routes = [",
"  { path: '', component: LoginComponent },",
"  { path: 'dashboard', component: DashboardComponent },",
"  { path: 'customer/:id', component: CustomerDetailsComponent }",
"];"
)

Add-Heading "6. Key Features" 1
Add-Bullets @(
"User signup and login flow",
"CSV upload with drag-drop support",
"CSV parsing and centralized data storage",
"Dashboard metrics and customer listing",
"Single two-step filtering with search",
"Due-soon and overdue status highlighting",
"Responsive and colorful interface"
)

Add-Heading "7. Challenges and Solutions" 1
Add-Heading "7.1 Filter Overwrite Issue" 2
Add-Para "Challenge: Independent filters overwrote each other. Solution: Introduced centralized combined filtering using shared state variables."
Add-Heading "7.2 UI Consistency" 2
Add-Para "Challenge: Different screens had inconsistent visual identity. Solution: Applied consistent gradient backgrounds and card styles across pages."

Add-Heading "8. Learning Outcomes" 1
Add-Bullets @(
"Applied Angular component-service-model architecture in a complete workflow.",
"Implemented real-world CSV parsing and client-side transformation.",
"Designed maintainable filter logic and route-driven navigation.",
"Improved UI readability and responsive design skills."
)

Add-Heading "9. Conclusion" 1
Add-Para "The project successfully delivers an internship-ready customer management system from authentication to detailed record analysis. The solution is modular and can be extended with backend APIs, database persistence, and role-based access control."

$footer = $doc.Sections.Item(1).Footers.Item(1).Range
$footer.Text = "Page "
$footer.Collapse(0)
$null = $footer.Fields.Add($footer, -1, "PAGE")
$footer.InsertAfter(" of ")
$footer.Collapse(0)
$null = $footer.Fields.Add($footer, -1, "NUMPAGES")
$footer.ParagraphFormat.Alignment = 1

foreach ($toc in $doc.TablesOfContents) { $toc.Update() }

$doc.SaveAs([ref]$outPath)
$doc.Close()
$word.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($tblR) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null

Write-Output "Styled report generated: $outPath"
