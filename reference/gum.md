# Gum Tools

## Tool Options
 
- choose
- confirm
- file
- filter
- format
- input
- join
- log
- pager
- spin
- style
- table
- write

## gum choose

### Variables 

| Variable | Description |
|---|---|
| $GUM_CHOOSE_PADDING | Padding "# #" |
| $GUM_CHOOSE_CURSOR_FOREGROUND | Cursor foreground colour |
| $GUM_CHOOSE_CURSOR_BACKGROUND | Cursor background colour |
| $GUM_CHOOSE_HEADER_FOREGROUND | Header foreground colour |
| $GUM_CHOOSE_HEADER_BACKGROUND | Header background colour |
| $GUM_CHOOSE_ITEM_FOREGROUND | Item foreground colour |
| $GUM_CHOOSE_ITEM_BACKGROUND | Item background colour |
| $GUM_CHOOSE_SELECTED_FOREGROUND | Selected foreground colour |
| $GUM_CHOOSE_SELECTED_BACKGROUND | Selected fackground colour |
| $GUM_CHOOSE_ORDERED | *Boolean* Maintain the order of the selected items |
| $GUM_CHOOSE_HEIGHT | Height of the list |
| $GUM_CHOOSE_CURSOR | Symbol for the cursor location |
| $GUM_CHOOSE_SHOW_HELP | *Boolean* Show keybinds help |
| $GUM_CHOOSE_TIMEOUT | Timeout until the choose returns the selected item in *seconds* |
| $GUM_CHOOSE_HEADER | Header value, Default: "Choose"|
| $GUM_CHOOSE_CURSOR_PREFIX | Prefix to show on the cursor item (hidden if limit is 1) |
| $GUM_CHOOSE_SELECTED_PREFIX | Prefix to show on selected items (hidden if limit is 1) |
| $GUM_CHOOSE_UNSELECTED_PREFIX | Prefix to show on unselected items (hidden if limit is 1) |
| $GUM_CHOOSE_SELECTED | Options that should start as selected. ",..." *Selects all if * is used* |
| $GUM_CHOOSE_INPUT_DELIMITER | Option delimiter when reading from STDIN Default: "\n" |
| $GUM_CHOOSE_OUTPUT_DELIMITER | Option delimiter when reading from STOUT Default: :\n" |
| $GUM_CHOOSE_LABEL_DELIMITER | Allows to set a delimiter so options can be set as label:value |
| $GUM_CHOOSE_STRIP_ANSI | *Boolean* Strip ANSI sequences when reading from STDIN |

### Running

gum choose <options> "Options to choose from"
Can | < >

### Flags

| Flag | Description |
|---|---|
| --limit=# | Maximum number of options to pick |
| --no-limit | Pick unlimited number of options (ignores limit) |
| --select-if-one | Select the given option if there is only 1 |

Can override variables by removing $GUM_CHOOSE_ from the beginning of the variable and replacing _ with a . after that.
for example
$GUM_CHOOSE_ITEM_FOREGROUND becomes --item.foreground

## gum confirm

### Variables

| Variable | Description |
|---|---|
| $GUM_CONFIRM_SHOW_HELP | *Boolean* Show keybind helpers |
| $GUM_CONFIRM_TIMEOUT | Time until confirm returns the selected value or default if provided |
| $GUM_CONFIRM_PROMPT_FOREGROUND | Prompt foreground colour |
| $GUM_CONFIRM_PROMPT_BACKGROUND | Prompt background colour |
| $GUM_CONFIRM_SELECTED_FOREGROUND | Selected foreground colour |
| $GUM_CONFIRM_SELECTED_BACKGROUND | Selected background colour |
| $GUM_CONFIRM_UNSELECTED_FOREGROUND | Unselected foreground colour |
| $GUM_CONFIRM_UNSELECTED_BACKGROUND | Unselected background colour |
| $GUM_CONFIRM_PADDING | Padding "# #" |

### Running

gum confirm <options> "Prompt to display"
Can | < >

### Flags

| Flag | Description |
|---|---|
| --default | Default confirmation option |
| --show-output | Print prompt and chosen action to output |
| --affirmative | Title of the affirmative action Default: "Yes" |
| --negative | Title of the negative action Default: "No" |

Can override variables by removing $GUM_CONFIRM_ from the beginning of the variable and replacing _ with a . after that.
for example
$GUM_CONFIRM_SELECTED_FOREGROUND becomes --selected.foreground

## gum file

### Variables

| Variable | Description |
|---|---|
| $GUM_FILE_CURSOR | Cursor symbol character |
| $GUM_FILE_ALL | Show hidden and 'dot' files |
| $GUM_FILE_PERMISSION | *Boolean* Show file permissions |
| $GUM_FILE_SIZE | *Boolean* Show file sizes "
| $GUM_FILE_FILE | *Boolean* Allow file selection |
| $GUM_FILE_DIRECTORY | *Boolean* Allow directory selection |
| $GUM_FILE_SHOW_HELP | *Boolean* Show keybind help |
| $GUM_FILE_TIMEOUT | Timeout until command aborts without a selection |
| $GUM_FILE_HEADER | Header value ""|
| $GUM_FILE_HEIGHT | Maximum number of files to display |
| $GUM_FILE_CURSOR_FOREGROUND | Cursor foreground colour |
| $GUM_FILE_CURSOR_BACKGROUND | Cursor background colour |
| $GUM_FILE_SYMLINK_FOREGROUND | Symlink foreground colour |
| $GUM_FILE_SYMLINK_BACKGROUND | Symlink background colour |
| $GUM_FILE_DIRECTORY_FOREGROUND | Directory foreground colour |
| $GUM_FILE_DIRECTORY_BACKGROUND | Directory background colour |
| $GUM_FILE_FILE_FOREGROUND | File foreground colour |
| $GUM_FILE_FILE_BACKGROUND | File background colour |
| $GUM_FILE_PERMISSIONS_FOREGROUND | Permissions foreground colour |
| $GUM_FILE_PERMISSIONS_BACKGROUND | Permissions background colour |
| $GUM_FILE_SELECTED_FOREGROUND | Selected foreground colour |
| $GUM_FILE_SELECTED_BACKGROUND | Selected background colour |
| $GUM_FILE_FILE_SIZE_FOREGROUND | File size foreground colour |
| $GUM_FILE_FILE_SIZE_BACKGROUND | File size background colour |
| $GUM_FILE_HEADER_FOREGROUND | Header foreground colour |
| $GUM_FILE_HEADER_BACKGROUND | Header background colour |
| $GUM_FILE_PADDING | Padding "0 0"

### Running

gum file <options> [<PATH>]
Can | < >

### Flags

There are no flags that are not available as variables.
Variables can be overridden by removing $GUM_FILE_ from the beginning of the variable and replacing _ with a . after that.
for example
$GUM_FILE_FILE_FOREGROUND becomes --file.foreground

## gum filter

### Variables

| Variable | Description |
|---|---|
| $GUM_FILTER_INDICATOR | |
| $GUM_FILTER_SELECTED | |
| $GUM_FILTER_SHOW_HELP | |
| $GUM_FILTER_SELECTED_PREFIX | |
| $GUM_FILTER_UNSELECTED_PREFIX | |
| $GUM_FILTER_HEADER | |
| $GUM_FILTER_PLACEHOLDER | |
| $GUM_FILTER_PROMPT | |
| $GUM_FILTER_WIDTH | |
| $GUM_FILTER_HEIGHT | |
| $GUM_FILTER_VALUE | |
| $GUM_FILTER_REVERSE | |
| $GUM_FILTER_FUZZY | |
| $GUM_FILTER_FUZZY_SORT | |
| $GUM_FILTER_TIMEOUT | |
| $GUM_FILTER_INPUT_DELIMITER | |
| $GUM_FILTER_OUTPUT_DELIMITER | |
| $GUM_FILTER_STRIP_ANSI | |
| $GUM_FILTER_INDICATOR_FOREGROUND | |
| $GUM_FILTER_INDICATOR_BACKGROUND | |
| $GUM_FILTER_SELECTED_PREFIX_FOREGROUND | |
| $GUM_FILTER_SELECTED_PREFIX_BACKGROUND | |
| $GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND | |
| $GUM_FILTER_UNSELECTED_PREFIX_BACKGROUND | |
| $GUM_FILTER_HEADER_FOREGROUND | |
| $GUM_FILTER_HEADER_BACKGROUND | |
| $GUM_FILTER_TEXT_FOREGROUND | |
| $GUM_FILTER_TEXT_BACKGROUND | |
| $GUM_FILTER_CURSOR_TEXT_FOREGROUND | |
| $GUM_FILTER_CURSOR_TEXT_BACKGROUND | |
| $GUM_FILTER_MATCH_FOREGROUND | |
| $GUM_FILTER_MATCH_BACKGROUND | |
| $GUM_FILTER_PROMPT_FOREGROUND | |
| $GUM_FILTER_PROMPT_BACKGROUND | |
| $GUM_FILTER_PLACEHOLDER_FOREGROUND | |
| $GUM_FILTER_PLACEHOLDER_BACKGROUND | |
| $GUM_FILTER_PADDING | |

### Running

gum filter [<options to filter>] <flags> 
Can | < >

### Flags 
| Flag | Description |
|---|---|
| --limit=1 | |
| --no-limit | |
| --select-if-one | |
| --[no-]strict | |

Variables can be overridden by removing $GUM_FILTER_ from the beginning of the variable and replacing _ with a . after that.
for example
$GUM_FILTER_STRIP_ANSI becomes --strip.ansi

## gum format

### Variables

| Variable | Description |
|---|---|
| $GUM_FORMAT_THEME | |
| $GUM_FORMAT_LANGUAGE | |
| $GUM_FORMAT_STRIP_ANSI | |
| $GUM_FORMAT_TYPE | |

### Running

gum format [<template>] <flags>

<template> is the string to format. Can also use | < >

### Flags

There are no flags that are not available as variables.
Variables can be overridden by removing $GUM_FORMAT_ from the beginning of the variable and replacing _ with a . after that.
for example
$GUM_FORMAT_STRIP_ANSI becomes --strip.ansi

## gum input

### Variables

| Variable | Description |
|---|---|
| $GUM_INPUT_PLACEHOLDER | |
| $GUM_INPUT_PROMPT | |
| $GUM_INPUT_CURSOR_MODE | |
| $GUM_INPUT_WIDTH | |
| $GUM_INPUT_SHOW_HELP | |
| $GUM_INPUT_HEADER | |
| $GUM_INPUT_TIMEOUT  | |
| $GUM_INPUT_STRIP_ANSI  | |
| $GUM_INPUT_PROMPT_FOREGROUND | |
| $GUM_INPUT_PROMPT_BACKGROUND | |
| $GUM_INPUT_PLACEHOLDER_FOREGROUND | |
| $GUM_INPUT_PLACEHOLDER_BACKGROUND | |
| $GUM_INPUT_CURSOR_FOREGROUND | |
| $GUM_INPUT_CURSOR_BACKGROUND | |
| $GUM_INPUT_HEADER_FOREGROUND | |
| $GUM_INPUT_HEADER_BACKGROUND | |
| $GUM_INPUT_PADDING  | |

### Running

gum input <flags>

### Flags

| Flag | Description |
|---|---|
| --password | |

Variables can be overridden by removing $GUM_INPUT_ from the beginning of the variable and replacing _ with a . after that.
for example
$GUM_INPUT_STRIP_ANSI becomes --strip.ansi

## gum join

### Variables

There are no variables that can be set for this command

### Running

gum join [<text>] <flags>

### Flags

| Flag | Description |
|---|---|
| --align | Text alignment |
| --horizontal | Join (potentially multi-line) strings horizontally |
| --vertical | Join (potentially multi-line) strings vertically |

## gum log

### Variables

| Variable | Description |
|---|---|
| $GUM_LOG_LEVEL | |
| $GUM_LOG_LEVEL_FOREGROUND | |
| $GUM_LOG_LEVEL_BACKGROUND | |
| $GUM_LOG_TIME_FOREGROUND | |
| $GUM_LOG_TIME_BACKGROUND | |
| $GUM_LOG_PREFIX_FOREGROUND | |
| $GUM_LOG_PREFIX_BACKGROUND | |
| $GUM_LOG_MESSAGE_FOREGROUND | |
| $GUM_LOG_MESSAGE_BACKGROUND | |
| $GUM_LOG_KEY_FOREGROUND | |
| $GUM_LOG_KEY_BACKGROUND | |
| $GUM_LOG_VALUE_FOREGROUND | |
| $GUM_LOG_VALUE_BACKGROUND | |
| $GUM_LOG_SEPARATOR_FOREGROUND | |
| $GUM_LOG_SEPARATOR_BACKGROUND | |

### Running

gum log [<text>] <flags>

### Flags


| Flag | Description |
|---|---| 
| --file=STRING | Log to file |
| --format | Format message using printf |
| --formatter="text"|The log formatter to use |
| --level="none" | The log level to use |
| --prefix=STRING | Prefix to print before the message |
| --structured | Use structured logging |
| --time="" | The time format to use (kitchen, layout, ansic, rfc822, etc...) |
| --min-level="" | |


## gum pager

###Variables

| Variable | Description |
|---|---|
| $GUM_PAGER_TIMEOUT | |
| $GUM_PAGER_FOREGROUND  | |
| $GUM_PAGER_BACKGROUND | |
| $GUM_PAGER_LINE_NUMBER_FOREGROUND | |
| $GUM_PAGER_LINE_NUMBER_BACKGROUND | |
| $GUM_PAGER_MATCH_FOREGROUND | |
| $GUM_PAGER_MATCH_BACKGROUND | |
| $GUM_PAGER_MATCH_HIGH_FOREGROUND | |
| $GUM_PAGER_MATCH_HIGH_BACKGROUND | |
| $GUM_PAGER_HELP_FOREGROUND | |
| $GUM_PAGER_HELP_BACKGROUND | |

### Running

gum pager [<content>] <flags>

### Flags

| Flag | Description |
|---|---|
| --show-line-numbers | Show line numbers |
| --[no-]soft-wrap | Soft wrap lines |

## gum spin

### Variables

| Variable | Description |
|---|---|
| $GUM_SPIN_SHOW_OUTPUT | |
| $GUM_SPIN_SHOW_ERROR | |
| $GUM_SPIN_SHOW_STDOUT | |
| $GUM_SPIN_SHOW_STDERR | |
| $GUM_SPIN_SPINNER | |
| $GUM_SPIN_TITLE | |
| $GUM_SPIN_ALIGN | |
| $GUM_SPIN_TIMEOUT | |
| $GUM_SPIN_SPINNER_FOREGROUND | |
| $GUM_SPIN_SPINNER_BACKGROUND | |
| $GUM_SPIN_TITLE_FOREGROUND | |
| $GUM_SPIN_TITLE_BACKGROUND | |
| $GUM_SPIN_PADDING | |

### Running

gum spin [<command>] <flags>

### Flags

There are no flags that cannot be expressed as variables

## gum style

### Variables

| Variable | Description |
|---|---|
| $FOREGROUND | |
| $BACKGROUND | |
| $BORDER | |
| $BORDER_BACKGROUND  | |
| $BORDER_FOREGROUND | |
| $ALIGN | |
| $HEIGHT | |
| $WIDTH | |
| $MARGIN | |
| $PADDING | |
| $BOLD | |
| $FAINT | |
| $ITALIC | |
| $STRIKETHROUGH | |
| $UNDERLINE | |
| $GUM_STYLE_STRIP_ANSI | |

### Running

gum style [<text>] <flags>

### Flags

| Flag | Description |
|---|---|
| --trim | Trim whitespaces on every input line |


## gum table 

### Variables

| Variable | Description |
|---|---|
| $GUM_TABLE_SHOW_HELP | |
| $GUM_TABLE_HIDE_COUNT | |
| $GUM_TABLE_LAZY_QUOTES | |
| $GUM_TABLE_FIELDS_PER_RECORD | |
| $GUM_TABLE_TIMEOUT | |
| $GUM_TABLE_BORDER_FOREGROUND | |
| $GUM_TABLE_BORDER_BACKGROUND | |
| $GUM_TABLE_CELL_FOREGROUND | |
| $GUM_TABLE_CELL_BACKGROUND | |
| $GUM_TABLE_HEADER_FOREGROUND | |
| $GUM_TABLE_HEADER_BACKGROUND | |
| $GUM_TABLE_SELECTED_FOREGROUND | |
| $GUM_TABLE_SELECTED_BACKGROUND | |
| $GUM_TABLE_PADDING | |

### Running

gum table 

### Flags

| Flag | Description |
|---|---|
| --separator | Row separator |
| --columns | Column names |
| --widths| Column widths |
| --height | Table height |
| --print | static print |
| --file | file path |
| --border| border style |

## gum write

### Variables

| Variable | Description |
|---|---|
| $GUM_WRITE_WIDTH | |
| $GUM_WRITE_HEIGHT | |
| $GUM_WRITE_HEADER | |
| $GUM_WRITE_PLACEHOLDER | |
| $GUM_WRITE_PROMPT | |
| $GUM_WRITE_SHOW_CURSOR_LINE | |
| $GUM_WRITE_SHOW_LINE_NUMBERS | |
| $GUM_WRITE_VALUE | |
| $GUM_WRITE_SHOW_HELP | |
| $GUM_WRITE_CURSOR_MODE | |
| $GUM_WRITE_TIMEOUT | |
| $GUM_WRITE_STRIP_ANSI | |
| $GUM_WRITE_BASE_FOREGROUND | |
| $GUM_WRITE_BASE_BACKGROUND | |
| $GUM_WRITE_CURSOR_LINE_NUMBER_FOREGROUND | |
| $GUM_WRITE_CURSOR_LINE_NUMBER_BACKGROUND | |
| $GUM_WRITE_CURSOR_LINE_FOREGROUND | |
| $GUM_WRITE_CURSOR_LINE_BACKGROUND | |
| $GUM_WRITE_CURSOR_FOREGROUND | |
| $GUM_WRITE_CURSOR_BACKGROUND | |
| $GUM_WRITE_END_OF_BUFFER_FOREGROUND | |
| $GUM_WRITE_END_OF_BUFFER_BACKGROUND | |
| $GUM_WRITE_LINE_NUMBER_FOREGROUND | |
| $GUM_WRITE_LINE_NUMBER_BACKGROUND | |
| $GUM_WRITE_HEADER_FOREGROUND | |
| $GUM_WRITE_HEADER_BACKGROUND | |
| $GUM_WRITE_PLACEHOLDER_FOREGROUND | |
| $GUM_WRITE_PLACEHOLDER_BACKGROUND | |
| $GUM_WRITE_PROMPT_FOREGROUND | |
| $GUM_WRITE_PROMPT_BACKGROUND | |
| $GUM_WRITE_PADDING | |

### Running

gum write

### Flags

| Flag | Description |
|---|---|
| --char-limit=0 | Maximum value length (0 for no limit) |
| --max-lines=0 | Maximum number of lines (0 for no limit) |

'''
This is not completed. Needs explainations and details for a lot of commands. All gum tools variables and flags are described here.
'''
