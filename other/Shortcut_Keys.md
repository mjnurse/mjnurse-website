# Shortcut Keys


## Bash


### !

| Key | Description |
|-----|-------------|
| `!!` | Run last command |
| `!$` | The last word of the previous command (same as ALT+.) |
| `!$:p` | Print out the word that !$ would substitute |
| `!*` | The previous command except for the first word (e.g., if you type find some_file.txt /, then !* would give you some_file.txt /) |
| `!*:p` | Print out what !* would substitute |
| `!blah` | Run the most recent command that starts with blah |
| `!blah:p` | Print out the command that !blah would run (also adds it as the latest command in the command history |

### Command Control

| Key | Description |
|-----|-------------|
| `CTRL+C` | Terminate the command |
| `CTRL+L` | Clear the screen |
| `CTRL+Q` | Allow output to the screen (if previously stopped using command above) |
| `CTRL+S` | Stops the output to the screen (for long running verbose command) |
| `CTRL+Z` | Suspend/stop the command |

### Command Editing

| Key | Description |
|-----|-------------|
| `ALT+B ALT+F` | Move backward/forward one word (or go to start of word the cursor is currently on) |
| `ALT+C` | Capitalize to end of word starting at cursor (whole word if cursor is at the beginning of word) |
| `ALT+L` | Make lowercase from cursor to end of word |
| `ALT+T` | Swap current word with previous |
| `ALT+U` | Make uppercase from cursor to end of word |
| `CTRL+A CTRL+E` | Go to the start/end of the command line |
| `CTRL+D CTRL+H` | Delete character after/before under cursor |
| `CTRL+F CTRL+B` | Move forward/backward one character |
| `CTRL+T` | Swap character under cursor with the previous one |
| `CTRL+U CTRL+K` | Delete from cursor to the start/end of the command line |
| `CTRL+W ALT+D` | Delete from cursor to start/end of word (whole word if at the boundary) |
| `CTRL+XX` | Move between start of command line and current cursor position (and back again) |
| `CTRL+Y` | Paste word or text that was cut using one of the deletion shortcuts (such as the one above) after the cursor |

### command Recall

| Key | Description |
|-----|-------------|
| `ALT+.` | Use the last word of the previous command |
| `CTRL+G` | Escape from history searching mode |
| `CTRL+J` | End the search at current history entry |
| `CTRL+N` | Next command in history (i.e., walk forward through the command history) |
| `CTRL+P` | Previous command in history (i.e., walk back through the command history) |
| `CTRL+R` | Search the history backwards |
| `CTRL+_` | Undo last command |

## Claude


### cli

| Key | Description |
|-----|-------------|
| `,RTN` | New line |

## Confluence

| Key | Description |
|-----|-------------|
| `//` | Opens the date picker |
| `Alt +SHIFT+DOWN` | Insert table row after |
| `Alt +SHIFT+UP` | Insert table row before |
| `CTRL+0` | Set paragraph style |
| `CTRL+1-6` | Set as heading 1-6 |
| `CTRL+7` | Preformatted |
| `CTRL+8` | Quote |
| `CTRL+ENTER` | Publish page |
| `CTRL+ENTER` | Publish |
| `CTRL+SHIFT+I` | Insert table |
| `CTRL+SHIFT+a` | Insert macro |
| `CTRL+SHIFT+b` | Bulleted list |
| `CTRL+SHIFT+d` | Insert markup |
| `CTRL+SHIFT+e` | Preview |
| `CTRL+SHIFT+n` | Numbered list |
| `CTRL+SHIFT+s` | Strikethrough |
| `CTRL+h` | Find / Replace |
| `CTRL+k` | Insert link |
| `CTRL+m` | Insert files & images |
| `CTRL+y` | Redo |
| `SHIFT+ENTER` | Insert a hard break |
| `SHIFT+TAB` | Outdent item when in a list / Move cursor to previous cell in the table |
| `TAB` | Indent item when in a list / Move cursor to next cell in the table |
| `e` | Open the editor |

## DrawIO


### Canvas

| Key | Description |
|-----|-------------|
| `ALT+Connect` | Connect to a Fixed Point |
| `ALT+Shift+C/T` | Clear Waypoints / Edit Tooltip |
| `Backspace or Delete` | Delete Selected Cells |
| `CTRL / Meta+Resize` | Centered / Group Resize |
| `CTRL / Shift+Drag` | Clone cell/Disconnect edge |
| `CTRL+Delete` | Delete with Connections |
| `CTRL+End` | Expand Container |
| `CTRL+Enter / D` | Duplicate |
| `CTRL+G` | Group |
| `CTRL+Home` | Collapse Container |
| `CTRL+L / ALT+Shift+L` | Lock/Unlock / Edit Link |
| `CTRL+R` | Turn / Rotate 90 Clockwise |
| `CTRL+Shift+B` | Send to Back |
| `CTRL+Shift+End` | Enter Group |
| `CTRL+Shift+F` | Bring to Front |
| `CTRL+Shift+Home` | Exit Group |
| `CTRL+Shift+U` | Ungroup |
| `CTRL+Shift+Y` | Autosize |
| `Shift+Resize` | Maintain Proportions |

### Cursor/Page Keys

| Key | Description |
|-----|-------------|
| `ALT+Cursor` | Scroll Page |
| `ALT+Shift+Cursor` | Clone and connect |
| `CTRL+Cursor` | Resize cell (pt, +Option on Mac) |
| `CTRL+Shift+Cursor` | Resize cell (grid size) |
| `CTRL+Shift+Pg Down` | Next Page |
| `CTRL+Shift+Pg Up` | Previous Page |
| `Cursor` | Scroll / Move cell (pt) |
| `Shift+Cursor` | Move cell (grid size) |

### Documents

| Key | Description |
|-----|-------------|
| `ALT+Drag / Drop` | Force Rubberband / Ignore Group |
| `ALT+Shift+A` | Connection Arrows |
| `CTRL+K` | Insert Rectangle |
| `CTRL+P` | Print |
| `CTRL+S` | Save |
| `CTRL+Shift+G` | Toggle grid |
| `CTRL+Shift+K` | Insert Ellipse |
| `CTRL+Shift+S` | Save as |
| `CTRL+Shift+X` | Insert Text |
| `CTRL+Shift+Z` | Redo (Linux/Mac) |
| `CTRL+Y` | Redo (Windows) |
| `CTRL+Z` | Undo |
| `Esc` | Cancel Action |
| `Hold ALT` | Ignores handles under the mouse |

### Labels

| Key | Description |
|-----|-------------|
| `CTRL+. / ,` | Superscript/Subscript on Selected Text |
| `CTRL+B / I` | Toggle Bold/Italic on Selected Text |
| `CTRL+U` | Toggle Underline on Selected Text |
| `Enter` | New Paragraph in Formatted Labels |
| `F2 / Enter` | Start Editing Label of Selected Cell |
| `F2 / Tab / Esc` | Stop Editing and Apply Value |
| `Shift+Enter` | New Line in Formatted Labels |

### Other

| Key | Description |
|-----|-------------|
| `ALT+Shift+P` | Connection Points |
| `CTRL / Shift+Esc` | Cancel Editing |
| `CTRL+Meta+Resize` | Centered group resize |
| `CTRL+Resize` | Non-recursive group resize |

### Selection

| Key | Description |
|-----|-------------|
| `(Shift+)Tab` | Select Next / Previous |
| `ALT+(Shift+)Tab` | Select Child / Parent |
| `ALT+Click` | Select Cell Below |
| `ALT+Shift+Drag` | Remove from Selection |
| `CTRL / Shift+Click` | Toggle Selection State |
| `CTRL+(Shift+)A` | Select All / None |
| `CTRL+Shift+I / E` | Select Vertices / Edges |
| `Shift+Drag` | Add to Selection |

### Sidebar/Connect

| Key | Description |
|-----|-------------|
| `ALT+(Shift / CTRL)+Click on a sidebar item` | Inserts and connects the selected item (Shift ignores current style) |
| `ALT+(Shift+)Drag from sidebar` | Disable replace, connect on drop (drop targets), Shift ignores current style |
| `Click on a sidebar item` | Connects unconnected side of selected edge |
| `Shift+Click on a sidebar item` | Replaces the selected item with the clicked one |
| `Shift+Connect` | Connect to shape outline (ignore connection points) |

### Styles

| Key | Description |
|-----|-------------|
| `CTRL+E` | Edit Style |
| `CTRL+Shift+C` | Copy Style |
| `CTRL+Shift+D` | Set as Default Style |
| `CTRL+Shift+R` | Clear Default Style |
| `CTRL+Shift+V` | Paste Style |
| `DrawIO Styles :: ALT+Shift+V` | Paste Size |
| `DrawIO Styles :: ALT+Shift+X` | Copy Size |

### Tools

| Key | Description |
|-----|-------------|
| `CTRL+M` | Edit Metadata |
| `CTRL+Shift+L` | Toggle Layers Window |
| `CTRL+Shift+M` | Edit Vertex Geometry |
| `CTRL+Shift+O` | Toggle Outline Window |
| `CTRL+Shift+P` | Toggle Format Panel |

### View

| Key | Description |
|-----|-------------|
| `ALT+Mouse wheel` | Canvas Zoom In/Out |
| `CTRL + (Numpad)` | Zoom In |
| `CTRL - (Numpad)` | Zoom Out |
| `CTRL 0` | Custom Zoom |
| `CTRL+H` | Reset View |
| `CTRL+J` | Fit Page |
| `CTRL+Shift+Connect` | Disable Connections |
| `CTRL+Shift+Drag` | Create / Remove Space |
| `CTRL+Shift+H` | Fit Window |
| `CTRL+Shift+J` | Fit Two Pages |
| `End` | Refresh |
| `Home` | Home |
| `Mouse wheel` | Canvas Vertical Scroll |
| `Shift+Mouse wheel` | Canvas Horizontal Scroll |
| `Space / Right mouse Drag` | Pan Canvas |

## Drive

| Key | Description |
|-----|-------------|
| `n` | Rename selected item. |
| `z` | Move selected items to new folder. |

## Excel


### Autofit Row

| Key | Description |
|-----|-------------|
| ``Ctrl+A, ALT+H, O, A` | Autofit all rows to content |

## Outlook


### Basic Navigation

| Key | Description |
|-----|-------------|
| `Alt or F6` | Show the access keys in the ribbon |
| `Alt+B or Alt+Left` | Go back to previous view in the main Outlook window |
| `Alt+B or Alt+Left` | Go back to previous view |
| `Alt+Down` | Open split buttons |
| `Alt+F` | Open the File menu |
| `Alt+H` | Open the Home tab |
| `Alt+J,S` | Open the Send/Receive tab |
| `Alt+O` | Open the Folder tab |
| `Alt+Q` | Go to the Tell Me search field |
| `Alt+Right` | Go forward to next view in the main Outlook window |
| `Alt+Right` | Go forward to next view |
| `Alt+Up or Ctrl+Comma (,), or Alt+Page Up` | In the Reading pane, go to the previous message |
| `Alt+V` | Open the View tab |
| `Alt+V, B, and then C for Calendar, P for People, T for Tasks, or O for Off` | Show the To-Do bar (peek) |
| `Arrow keys` | Move around within the Folder pane |
| `Ctrl+1` | Switch to the Mail view |
| `Ctrl+2` | Switch to the Calendar view |
| `Ctrl+3` | Switch to the Contacts view |
| `Ctrl+4` | Switch to the Tasks view |
| `Ctrl+5` | Switch to the Notes |
| `Ctrl+6` | Switch to the Folder list in the Folder pane |
| `Ctrl+7` | Switch to Shortcuts |
| `Ctrl+8` | Open Journal |
| `Ctrl+Comma (,)` | Switch to previous open message |
| `Ctrl+E` | Open the Search tab |
| `Ctrl+Period (.)` | Switch to next open message |
| `Ctrl+Shift+B` | Open the Address Book |
| `Ctrl+Shift+F10` | Show the tooltip for the ribbon element currently in focus |
| `Ctrl+Shift+Tab key or Shift+Tab key` | Move between the Folder pane, the main Outlook window, the Reading pane, and the To-Do bar |
| `Ctrl+Shift+W` | Select the InfoBar and, if available, show the menu of commands |
| `Ctrl+Tab` | Move around message header lines in the Folder pane or an open message |
| `Ctrl+Tab` | Move between the Navigation pane and the calendar |
| `Ctrl+Y` | Go to a different folder |
| `F3 or Ctrl+E` | Go to the Search box |
| `F6` | Move between the ribbon and the calendar |
| `Left or Right, respectively` | Collapse or expand a group in the email message list |
| `Shift+Spacebar` | In the Reading pane, page up through the text |
| `Spacebar` | In the Reading pane, page down through the text |
| `Tab key or F6` | Move between the Outlook window, the smaller panes in the Folder pane, the Reading pane, and the sections in the To-Do bar |

### Calendar Date Navigator

| Key | Description |
|-----|-------------|
| `Alt+Down` | Go to the same day in the next week |
| `Alt+End` | Go to the last day of the current week |
| `Alt+Home` | Go to the first day of the current week |
| `Alt+Up` | Go to the same day in the previous week |

### Calendar Day/Week/Month

| Key | Description |
|-----|-------------|
| `Alt+-` | Switch to the Week view |
| `Alt+0` | View 10 days |
| `Alt+=` | Switch to the Month view |
| `Alt+Down` | Go to the same day in the next week |
| `Alt+Up` | Go to the same day in the previous week |
| `Alt+key for number of days` | View from one through nine days |
| `Ctrl+Tab or F6` | Move between the Calendar view, TaskPad, and Folder list |
| `Left` | Go to the previous day |
| `Right` | Go to the next day |
| `Shift+Tab` | Select the previous appointment |

### Calendar Month View

| Key | Description |
|-----|-------------|
| `Home` | Go to the first day of the week |
| `Page down` | Go to the same day of the week in the next page |
| `Page up` | Go to the same day of the week in the previous page |

### Calendar Single Day View

| Key | Description |
|-----|-------------|
| `Alt+Down` | Go to the same day in the next week |
| `Alt+Up` | Go to the same day in the previous week |
| `Down` | Select the next block of time |
| `End` | Select the time that ends your work day |
| `Home` | Select the time that begins your work day |
| `Page down` | Select the block of time at the bottom of the screen |
| `Page up` | Select the block of time at the top of the screen |
| `Shift+Up or Shift+Down` | Extend or reduce the selected time |
| `Up` | Select the previous block of time |

### Calendar Week View

| Key | Description |
|-----|-------------|
| `End` | Go to the end of work hours for the selected day |
| `Home` | Go to the start of work hours for the selected day |
| `Page down` | Go down one page view in the selected day |
| `Page up` | Go up one page view in the selected day |
| `Shift+Left, Shift+Right, Shift+Up, Shift+Down, Shift+Home, or Shift+End` | Change the duration of the selected block of time |

### Calendar

| Key | Description |
|-----|-------------|
| `Alt+- or Ctrl+Alt+3` | Switch to the Full Week view |
| `Alt+0` | Show ten days in the calendar |
| `Alt+1` | Show one day in the calendar |
| `Alt+2` | Show two days in the calendar |
| `Alt+3` | Show three days in the calendar |
| `Alt+4` | Show four days in the calendar |
| `Alt+5` | Show five days in the calendar |
| `Alt+6` | Show six days in the calendar |
| `Alt+7` | Show seven days in the calendar |
| `Alt+8` | Show eight days in the calendar |
| `Alt+9` | Show nine days in the calendar |
| `Alt+= or Ctrl+Alt+4` | Switch to Month view |
| `Alt+D` | Dismiss the reminder |
| `Alt+Down` | Go to the next week |
| `Alt+End` | Go to the end of the week |
| `Alt+H+I` | Open the New Items menu to select which item you'd like to create |
| `Alt+H+R or Ctrl+Alt+1` | Show the daily view |
| `Alt+H,A,B` | Open the address book |
| `Alt+H,C,G` | Create a new calendar group or add a department calendar |
| `Alt+H,C,O` | Open the Outlook Options dialog box for calendars |
| `Alt+H,E` | Email a selected calendar to a contact |
| `Alt+H,F,C` | Search for contacts |
| `Alt+H,F,P` | View and edit the sharing permissions for a folder |
| `Alt+H,F,W or Ctrl+F` | Forward an appointment or meeting |
| `Alt+H,O,C` | Add shared calendars from your contacts, or create a new calendar |
| `Alt+H,O,D` | Show today in the calendar |
| `Alt+H,P,O` | Publish a calendar online |
| `Alt+H,S,C` | Share a calendar with others |
| `Alt+H,S,V or Ctrl+Alt+5` | Show the selected schedule in a horizontal layout if you want to compare calendars to schedule meetings |
| `Alt+H,X` | Show the next seven days |
| `Alt+Home` | Go to the start of the week |
| `Alt+O` | Open an appointment when the reminder appears |
| `Alt+Page down` | Go to the next month |
| `Alt+Page up` | Go to the previous month |
| `Alt+S ` | Snooze the reminder |
| `Alt+Up` | Go to the previous week |
| `Alt+V,M` | Open the reminder window |
| `Alt+X` | Open the calendar scheduling assistant from the meeting window |
| `Ctrl+Alt+2` | Switch to the Work Week view |
| `Ctrl+Comma (,) or Ctrl+Shift+Comma (,)` | Go to the previous appointment |
| `Ctrl+E` | Jump to Search |
| `Ctrl+G or Alt+H+L` | Go to a date |
| `Ctrl+G` | Set up recurrence for an open appointment or meeting |
| `Ctrl+Left` | Go to the previous day |
| `Ctrl+N` | Create an appointment (when in the Calendar view) |
| `Ctrl+Period (.) or Ctrl+Shift+Period (.)` | Go to the next appointment |
| `Ctrl+R` | Reply to a meeting request with a message |
| `Ctrl+Right` | Go to the next day |
| `Ctrl+Shift+A` | Create an appointment (in any Outlook view) |
| `Ctrl+Shift+Q or Alt+H,M,R` | Create a meeting request |
| `Ctrl+Shift+R` | Select the Reply All option |

### Create an Item or File

| Key | Description |
|-----|-------------|
| `Ctrl+Shift+A` | Create an appointment |
| `Ctrl+Shift+C` | Create a contact |
| `Ctrl+Shift+E` | Create a folder |
| `Ctrl+Shift+H` | Create a Microsoft Office document |
| `Ctrl+Shift+K` | Create a task |
| `Ctrl+Shift+L` | Create a contact group |
| `Ctrl+Shift+M` | Create a message |
| `Ctrl+Shift+N` | Create a note |
| `Ctrl+Shift+P` | Create a Search folder |
| `Ctrl+Shift+Q` | Create a meeting request |
| `Ctrl+Shift+S` | Post to the selected folder |
| `Ctrl+Shift+X` | Create a fax |
| `Ctrl+T` | Post a reply in the selected folder |

### Format Text

| Key | Description |
|-----|-------------|
| `Alt+O` | Display the Format Text tab on the ribbon |
| `Ctrl+B` | Apply bold formatting |
| `Ctrl+C or Ctrl+Insert` | Copy a selection |
| `Ctrl+E` | Center text |
| `Ctrl+I` | Apply italic formatting |
| `Ctrl+K` | Insert a hyperlink |
| `Ctrl+L` | Left-align a paragraph |
| `Ctrl+Left bracket ([) or Ctrl+Shift+Less-than sign (<)` | Decrease the font size |
| `Ctrl+Q` | Remove paragraph formatting |
| `Ctrl+R` | Right-align a paragraph |
| `Ctrl+Right bracket (]) or Ctrl+Shift+Greater-than sign (>)` | Increase the font size |
| `Ctrl+Shift+H` | Delete the next word |
| `Ctrl+Shift+J` | Justify text (Stretch a paragraph to fit between the margins} |
| `Ctrl+Shift+K` | Toggle the case of the selected text between small caps and all caps |
| `Ctrl+Shift+L` | Add a bulleted list |
| `Ctrl+Shift+P` | Display the Font dialog box |
| `Ctrl+Shift+S` | Apply styles |
| `Ctrl+Shift+T` | Decrease indent |
| `Ctrl+Shift+T` | Reduce a hanging indent |
| `Ctrl+Shift+Z or Ctrl+Spacebar` | Clear the formatting |
| `Ctrl+T` | Create a hanging indent |
| `Ctrl+T` | Increase indent |
| `Ctrl+U` | Underline text |
| `Ctrl+V or Shift+Insert` | Paste the copied or cut selection |
| `Ctrl+X or Shift+Delete` | Cut a selection |
| `Shift+F3` | Switch the case of the first letter in a selected word or line |

### Frequently Used

| Key | Description |
|-----|-------------|
| `Alt+H` | Go to the Home tab |
| `Alt+H,F,W` | Forward a message |
| `Alt+H,M,V, and select a folder from the list` | Move an item to a folder |
| `Alt+H,R,A` | Select the Reply All option |
| `Alt+H,R,P` | Reply to a message |
| `Alt+J,A,2,A,V` | Open the Save As dialog box on the Attachment tab |
| `Alt+J,S` | Go to the Send/Receive tab |
| `Alt+N,A,F` | Insert a file |
| `Alt+S` | Send a message |
| `Ctrl+2` | Go to Calendar |
| `Ctrl+C or Ctrl+Insert` | Copy an item |
| `Ctrl+E or F3` | Search for an item |
| `Ctrl+M or F9` | Check for new messages |
| `Ctrl+Shift+A` | Create an appointment |
| `Ctrl+Shift+K` | New task |
| `Ctrl+Shift+M` | Create a new message |
| `Delete` | Delete an item (when a message, task, or meeting is selected) |

### Mail - Folder Pane

| Key | Description |
|-----|-------------|
| `Shift+F10,D` | Delete a selected folder in the list (default folders, such as Inbox, Outbox, Drafts, and Sent cannot be deleted) |

### Mail Folder Pane

| Key | Description |
|-----|-------------|
| `F2` | Rename a selected folder in the list of folders |
| `Left` | Collapse a selected group or folder with subfolders |
| `Right` | Expand a selected group or folder with subfolders |
| `Shift+F10,N` | Create a new folder |
| `Spacebar or Enter` | Move to the Message list from the Folder pane |
| `Spacebar or Enter` | Open a selected item in the Folder pane |
| `Up and Down` | Move around within the Folder pane |

### Mail Message List

| Key | Description |
|-----|-------------|
| `Alt+Enter` | Show email properties |
| `Alt+H+D` | Delete a message |
| `Alt+H,F,W` | Forward a message |
| `Alt+H,J,O` | Set the junk mail options |
| `Alt+H,R,A` | Select the Reply All option |
| `Alt+H,R,P` | Reply to a message |
| `Alt+H,X` | Ignore a message |
| `Alt+J,S,M,C` | Mark an item to download a copy |
| `Alt+J,S,M,T` | Mark an item to download |
| `Alt+J,S,U,K` | Unmark all items to download |
| `Alt+J,S,U,U` | Unmark an item to download |
| `Ctrl+Alt+S` | Set how often Outlook checks for new messages |
| `Ctrl+P` | Print a message |
| `Ctrl+Q` | Mark a message as read |
| `Ctrl+Shift+G` | Add Custom Flag to message |
| `Ctrl+Shift+S` | Post to a folder |
| `Ctrl+Shift+V` | Move message to folder |
| `Ctrl+Shift+W` | Display a blocked content menu |
| `Ctrl+Shift+W,P` | Download blocked pictures or images |
| `Ctrl+Shift+Y` | Copy item to a folder |
| `Ctrl+Spacebar` | Select or cancel selection of the active item |
| `Ctrl+U` | Mark a message as unread |
| `Ctrl+Up or Ctrl+Down` | Go to the next or previous item without extending the selection |
| `Ctrl+Up or Down, and then, to select each message, press Spacebar` | Select multiple non-adjacent messages |
| `Down and Up` | Move down and up in the message list |
| `Enter` | Open a message |
| `Left` | Collapse groups of messages (for example, Last Week) |
| `Page down` | Go to the item at the bottom of the screen |
| `Page up` | Go to the item at the top of the screen |
| `Right` | Expand groups of messages (for example, Last Week) |
| `Shift+Down or Up` | Select multiple adjacent messages |
| `Shift+F10,J,then the Up or Down, and then Enter` | Mark message as junk or not junk |
| `Shift+F10,U,T (in Narrator, Insert)` | Add Follow Up or Quick Flag to message |
| `Shift+Up or Shift+Down` | Extend or reduce the selected items by one item |

### Mail Reading Pane

| Key | Description |
|-----|-------------|
| `Alt+R` | Jump to the Reply button |
| `Alt+Up or Ctrl+Comma (,), or Alt+Page up` | Go to the previous message |
| `Ctrl+Shift+W` | In an email message, select the InfoBar and, if available, show the options menu |
| `Esc` | Close the InfoBar menu |
| `Shift+Spacebar` | Page up through text |
| `Shift+Tab` | Move to previous field |
| `Spacebar` | Page down through text |
| `Tab key or Shift+Tab` | Move to the next or previous link |
| `Tab key` | Move to the next field |

### Mail

| Key | Description |
|-----|-------------|
| `Alt+Enter` | Show the properties for the selected item |
| `Alt+J,S,M,T` | Check the Mark for download status |
| `Alt+J,S,P (when a Send/Receive is in progress)` | Display the Send/Receive progress |
| `Alt+J,S,S` | Start a send/receive action |
| `Alt+S` | Send a message |
| `Ctrl+Alt+F` | Forward a message as an attachment |
| `Ctrl+Alt+J` | Mark a message as not junk |
| `Ctrl+Alt+M` | Mark an item for download |
| `Ctrl+Alt+P` | Open the MailTip in the composed message |
| `Ctrl+Alt+R` | Reply with a meeting request |
| `Ctrl+Alt+S` | Define Send/Receive groups |
| `Ctrl+Enter` | Send a message |
| `Ctrl+F` | Forward a message |
| `Ctrl+K` | Check names |
| `Ctrl+M or F9` | Check for new messages |
| `Ctrl+N` | Create a message (when in Mail view) |
| `Ctrl+O` | Open a received message |
| `Ctrl+P` | Print an item |
| `Ctrl+Q` | Mark a message as read |
| `Ctrl+R` | Reply to a message |
| `Ctrl+S` | Save an item |
| `Ctrl+Shift+B` | Open the Address Book |
| `Ctrl+Shift+D` | Delete and ignore a conversation |
| `Ctrl+Shift+G` | Display the Flag for follow up dialog box |
| `Ctrl+Shift+I` | Display blocked external content (in a message) |
| `Ctrl+Shift+I` | Switch to Inbox |
| `Ctrl+Shift+M` | Create a message (from any Outlook view) |
| `Ctrl+Shift+N` | Apply Normal style |
| `Ctrl+Shift+O` | Switch to Outbox |
| `Ctrl+Shift+R` | Select the Reply to All option |
| `Ctrl+Shift+S` | Post to a folder |
| `Ctrl+U` | Mark a message as unread |
| `Down` | Go to the next message |
| `F12` | Open the Save as dialog box |
| `F4` | Find or replace text |
| `Insert` | Add a Quick flag to an unopened message |
| `Shift+F4` | Find the next item |
| `Shift+F9` | Start a send/receive action for the current folder, retrieving full items (header, item, and any attachments) |
| `Up` | Go to the previous message |

### Search

| Key | Description |
|-----|-------------|
| `Ctrl+Alt+A` | Expand the search to include All Mail Items, All Calendar Items, or All Contact Items, depending on the module you are in |
| `Ctrl+Alt+K` | Expand search to include items from the current folder |
| `Ctrl+Alt+Z` | Expand search to include subfolders |
| `Ctrl+E or F3` | Go to the Search field to find a message or another item |
| `Ctrl+H` | Find and replace text, symbols, or some formatting commands when in the Reading pane or in an open item |
| `Ctrl+Shift+F` | Use Advanced Find |
| `Ctrl+Shift+P` | Create a Search folder |
| `Esc` | Clear the search results |
| `F4` | Search for text within an open item |

### Tasks

| Key | Description |
|-----|-------------|
| `Ctrl+A` | Select all items |
| `Ctrl+C` | Accept a task request |
| `Ctrl+D` | Decline a task request |
| `Ctrl+D` | Delete selected item |
| `Ctrl+E` | Find a task or other item |
| `Ctrl+F` | Forward a task as an attachment |
| `Ctrl+N` | Create a task when in Tasks view |
| `Ctrl+O` | Open the selected item |
| `Ctrl+P` | Print the selected item |
| `Ctrl+Shift+Alt+U` | Create a task request |
| `Ctrl+Shift+K` | Create a task from any Outlook view |
| `Ctrl+Y` | Open the Go to Folder dialog box |
| `Ctrl+Z` | Undo the last action |
| `F6` | Switch between the Folder pane, Tasks list, and To-Do bar |
| `Insert` | Flag an item or mark complete |

### Use Flags

| Key | Description |
|-----|-------------|
| `Ctrl+Shift+G` | Open the Flag for Follow Up dialog box to assign a flag |

## Slack

| Key | Description |
|-----|-------------|
| `+ (Plus) OR A` | Show invite list during call |
| `:[Character]` | Show autocomplete options for emoji |
| `@[Character]` | Show autocomplete options for display names |
| `@[username]` | Notify specific person |
| `@channel` | Notify all members of channel, whether they're active or not |
| `@everyone` | Notify all members of channel #general |
| `@here` | Notify active members of channel |
| `ALT+DownArrow` | Jump to next channel or DM |
| `ALT+SHIFT+DownArrow` | Jump to next unread channel or DM |
| `ALT+SHIFT+UpArrow` | Jump to previous unread channel or DM |
| `ALT+UpArrow` | Jump to previous channel or DM |
| `ALT+click message` | Mark message as oldest unread message |
| `CTRL+,` | Open Preferences |
| `CTRL+.` | Toggle right-hand pane |
| `CTRL+/` | Open Keyboard Shortcuts pane |
| `CTRL+ALT` | Show numbers assigned to workspaces in sidebar |
| `CTRL+B` | Bold selected text |
| `CTRL+F` | Search the current channel or DM |
| `CTRL+I` | Italicize selected text |
| `CTRL+K` | Open Quick Switcher |
| `CTRL+SHIFT+7` | Format selected text as numbered list |
| `CTRL+SHIFT+8` | Format selected text as bulleted list |
| `CTRL+SHIFT+>` | Indent selected text |
| `CTRL+SHIFT+A` | Open All Unreads view |
| `CTRL+SHIFT+C` | Format selected text as inline code |
| `CTRL+SHIFT+Enter` | Create snippet in current channel or DM |
| `CTRL+SHIFT+I` | Open Channel Details pane |
| `CTRL+SHIFT+K` | Browse DMs |
| `CTRL+SHIFT+L` | Browse channel list |
| `CTRL+SHIFT+M` | Open Activity pane |
| `CTRL+SHIFT+S` | Open Starred Items pane |
| `CTRL+SHIFT+T` | Open Threads view |
| `CTRL+SHIFT+W` | Open Workspace Directory |
| `CTRL+SHIFT+X` | Strike through selected text |
| `CTRL+SHIFT+Y` | Set or edit your Slack status |
| `CTRL+SHIFT+[` | Switch to previous workspace |
| `CTRL+SHIFT+]` | Switch to next workspace |
| `CTRL+U` | Upload file to current channel or DM |
| `CTRL+[Number]` | Switch to specific workspace |
| `ESC` | Mark all messages in current channel or DM as read |
| `SHIFT+DownArrow` | Select text to end of current line in message draft |
| `SHIFT+ESC` | Mark all messages as read |
| `SHIFT+Enter` | Insert new line in message draft |
| `SHIFT+UpArrow` | Select text to beginning of current line in message draft |
| `UpArrow` | Edit your last message in current channel or DM |
| `#[Character]` | Show autocomplete options for channel names |
| `e+(1-9)` | View and select emoji during call |
| `m` | Toggle mute during call |
| `v` | Toggle video during call |

## VS Code

| Key | Description |
|-----|-------------|
| `CTRL+K V` | Markdown editing - Show text and preview side-by-side. |
| `SHIFT+CTRL+K` | Markdown editing - Switch between text and preview. |

## Windows

| Key | Description |
|-----|-------------|
| `CTRL-SHIFT-ESCAPE` | Task Manager |
| `WIN-H` | Dictate |
| `WIN-X` | Quick Link Menu |
