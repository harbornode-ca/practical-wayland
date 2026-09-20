# Gum CLI Reference

Project defaults are in `ref/gumVariables.md`. Log levels/formats/dates are in `ref/gum-log.md`.

Override rule: `$GUM_<CMD>_<NAME>` -> `--<name>` or `--<name>.foreground` (strip prefix, lower-case, `_` -> `.`). Example: `$GUM_CHOOSE_ITEM_FOREGROUND` -> `--item.foreground`.

## Tool Overview

- `choose` — Choose from a list
- `confirm` — Yes/No confirmation
- `file` — Pick a file/folder
- `filter` — Fuzzy filter a list
- `format` — Format string via Glamour (markdown/template/code/emoji)
- `input` — Single-line text input
- `join` — Join text horizontally/vertically
- `log` — Log messages
- `pager` — Scroll content
- `spin` — Spinner while running a command
- `style` — Apply color/border/spacing
- `table` — Render/select from a table
- `write` — Multi-line text input

---

## gum choose

Pick one or more options.

### Variables

| Variable | Description |
|---|---|
| `$GUM_CHOOSE_PADDING` | Padding (`"0 0"`). |
| `$GUM_CHOOSE_CURSOR_FOREGROUND` | Cursor foreground color. |
| `$GUM_CHOOSE_CURSOR_BACKGROUND` | Cursor background color. |
| `$GUM_CHOOSE_HEADER_FOREGROUND` | Header foreground color. |
| `$GUM_CHOOSE_HEADER_BACKGROUND` | Header background color. |
| `$GUM_CHOOSE_ITEM_FOREGROUND` | Unselected item foreground color. |
| `$GUM_CHOOSE_ITEM_BACKGROUND` | Unselected item background color. |
| `$GUM_CHOOSE_SELECTED_FOREGROUND` | Selected item foreground color (default `212`). |
| `$GUM_CHOOSE_SELECTED_BACKGROUND` | Selected item background color. |
| `$GUM_CHOOSE_ORDERED` | Boolean — maintain order of selected items. |
| `$GUM_CHOOSE_HEIGHT` | Height of the list (default `10`). |
| `$GUM_CHOOSE_CURSOR` | Cursor symbol (default `"> "`). |
| `$GUM_CHOOSE_SHOW_HELP` | Boolean — show keybind help. |
| `$GUM_CHOOSE_TIMEOUT` | Timeout until abort (`0s` = no timeout). |
| `$GUM_CHOOSE_HEADER` | Header text (default `"Choose:"`). |
| `$GUM_CHOOSE_CURSOR_PREFIX` | Prefix on cursor item, hidden if `limit=1` (default `"• "`). |
| `$GUM_CHOOSE_SELECTED_PREFIX` | Prefix on selected items, hidden if `limit=1` (default `"✓ "`). |
| `$GUM_CHOOSE_UNSELECTED_PREFIX` | Prefix on unselected items, hidden if `limit=1` (default `"• "`). |
| `$GUM_CHOOSE_SELECTED` | Comma-separated options to pre-select (`*` = all). |
| `$GUM_CHOOSE_INPUT_DELIMITER` | Delimiter when reading STDIN (default `"\n"`). |
| `$GUM_CHOOSE_OUTPUT_DELIMITER` | Delimiter when writing STDOUT (default `"\n"`). |
| `$GUM_CHOOSE_LABEL_DELIMITER` | Delimiter for `label:value` options. |
| `$GUM_CHOOSE_STRIP_ANSI` | Boolean — strip ANSI sequences from STDIN. |

### Flags

| Flag | Description |
|---|---|
| `--ordered` | Maintain order of selected options. |
| `--height` | Height of list. |
| `--cursor` | Cursor symbol. |
| `--[no-]show-help` | Show help keybinds. |
| `--timeout` | Timeout duration. |
| `--header` | Header text. |
| `--cursor-prefix` | Prefix on cursor item. |
| `--selected-prefix` | Prefix on selected items. |
| `--unselected-prefix` | Prefix on unselected items. |
| `--selected` | Options to pre-select. |
| `--input-delimiter` | Delimiter reading STDIN. |
| `--output-delimiter` | Delimiter writing STDOUT. |
| `--label-delimiter` | Delimiter for `label:value`. |
| `--[no-]strip-ansi` | Strip ANSI on STDIN. |
| `--limit=1` | Max options to pick. |
| `--no-limit` | Pick unlimited options (ignores limit). |
| `--select-if-one` | Auto-select if only one option. |

Style flags are the color/padding vars above exposed as `--cursor.foreground`, `--header.foreground`, `--item.foreground`, `--selected.foreground`, `--padding`, etc.

### Running

```bash
gum choose "Option A" "Option B" "Option C"
printf "a\nb\nc" | gum choose
gum choose --limit 2 --header "Pick two:" a b c
```

---

## gum confirm

Yes/No prompt. Exit code `0` = affirmative.

### Variables

| Variable | Description |
|---|---|
| `$GUM_CONFIRM_SHOW_HELP` | Boolean — show help keybinds. |
| `$GUM_CONFIRM_TIMEOUT` | Timeout until return (`0s` = wait forever). |
| `$GUM_CONFIRM_PROMPT_FOREGROUND` | Prompt foreground color (default `#7571F9`). |
| `$GUM_CONFIRM_PROMPT_BACKGROUND` | Prompt background color. |
| `$GUM_CONFIRM_SELECTED_FOREGROUND` | Selected button foreground (default `230`). |
| `$GUM_CONFIRM_SELECTED_BACKGROUND` | Selected button background (default `212`). |
| `$GUM_CONFIRM_UNSELECTED_FOREGROUND` | Unselected button foreground (default `254`). |
| `$GUM_CONFIRM_UNSELECTED_BACKGROUND` | Unselected button background (default `235`). |
| `$GUM_CONFIRM_PADDING` | Padding (default `"0 0"`). |

### Flags

| Flag | Description |
|---|---|
| `--default` | Default to affirmative (`true`) or negative (`false`). Used on timeout. |
| `--show-output` | Print prompt and choice to output. |
| `--affirmative="Yes"` | Title of affirmative action. |
| `--negative="No"` | Title of negative action. |
| `--[no-]show-help` | Show help keybinds. |
| `--timeout` | Timeout duration. |

Style override: `$GUM_CONFIRM_PROMPT_FOREGROUND` -> `--prompt.foreground`, etc.

### Running

```bash
gum confirm "Continue Installation?" --affirmative "Yes" --negative "No"
gum confirm "Reboot now?" --default
if gum confirm "Proceed?"; then echo yes; fi
```

---

## gum file

Pick a file/directory via TUI.

### Variables

| Variable | Description |
|---|---|
| `$GUM_FILE_CURSOR` | Cursor character (default `">"`). |
| `$GUM_FILE_ALL` | Show hidden/dot files. |
| `$GUM_FILE_PERMISSION` | Boolean — show file permissions. |
| `$GUM_FILE_SIZE` | Boolean — show file sizes. |
| `$GUM_FILE_FILE` | Boolean — allow file selection. |
| `$GUM_FILE_DIRECTORY` | Boolean — allow directory selection. |
| `$GUM_FILE_SHOW_HELP` | Boolean — show help keybinds. |
| `$GUM_FILE_TIMEOUT` | Timeout until abort (`0s` = no timeout). |
| `$GUM_FILE_HEADER` | Header text (default `""`). |
| `$GUM_FILE_HEIGHT` | Max files to display (default `10`). |
| `$GUM_FILE_CURSOR_FOREGROUND` | Cursor foreground (default `212`). |
| `$GUM_FILE_CURSOR_BACKGROUND` | Cursor background. |
| `$GUM_FILE_SYMLINK_FOREGROUND` | Symlink foreground (default `36`). |
| `$GUM_FILE_SYMLINK_BACKGROUND` | Symlink background. |
| `$GUM_FILE_DIRECTORY_FOREGROUND` | Directory foreground (default `99`). |
| `$GUM_FILE_DIRECTORY_BACKGROUND` | Directory background. |
| `$GUM_FILE_FILE_FOREGROUND` | File foreground. |
| `$GUM_FILE_FILE_BACKGROUND` | File background. |
| `$GUM_FILE_PERMISSIONS_FOREGROUND` | Permissions foreground (default `244`). |
| `$GUM_FILE_PERMISSIONS_BACKGROUND` | Permissions background. |
| `$GUM_FILE_SELECTED_FOREGROUND` | Selected foreground (default `212`). |
| `$GUM_FILE_SELECTED_BACKGROUND` | Selected background. |
| `$GUM_FILE_FILE_SIZE_FOREGROUND` | File size foreground (default `240`). |
| `$GUM_FILE_FILE_SIZE_BACKGROUND` | File size background. |
| `$GUM_FILE_HEADER_FOREGROUND` | Header foreground (default `99`). |
| `$GUM_FILE_HEADER_BACKGROUND` | Header background. |
| `$GUM_FILE_PADDING` | Padding (default `"0 0"`). |

### Flags

No extra flags beyond the variables above (plus `-c`/`-a`/`-p`/`-s` shorthands). All vars are available as `--cursor`, `--all`, `--permissions`, `--size`, `--file`, `--directory`, `--show-help`, `--timeout`, `--header`, `--height`, and style flags like `--cursor.foreground`.

### Running

```bash
gum file
gum file /etc --file --all --header "Pick a file:"
```

---

## gum filter

Fuzzy filter a list (single/multi-select).

### Variables

| Variable | Description |
|---|---|
| `$GUM_FILTER_INDICATOR` | Selection indicator (default `"•"`). |
| `$GUM_FILTER_SELECTED` | Pre-selected options (`,…`, `*` = all). |
| `$GUM_FILTER_SHOW_HELP` | Boolean — show help keybinds. |
| `$GUM_FILTER_SELECTED_PREFIX` | Prefix for selected items, hidden if `limit=1` (default `" ◉ "`). |
| `$GUM_FILTER_UNSELECTED_PREFIX` | Prefix for unselected items, hidden if `limit=1` (default `" ○ "`). |
| `$GUM_FILTER_HEADER` | Header text. |
| `$GUM_FILTER_PLACEHOLDER` | Placeholder text (default `"Filter..."`). |
| `$GUM_FILTER_PROMPT` | Prompt text (default `"> "`). |
| `$GUM_FILTER_WIDTH` | Input width (`0` = auto). |
| `$GUM_FILTER_HEIGHT` | Input height (`0` = auto). |
| `$GUM_FILTER_VALUE` | Initial filter value. |
| `$GUM_FILTER_REVERSE` | Display from bottom of screen. |
| `$GUM_FILTER_FUZZY` | Boolean — fuzzy matching (vs prefix). |
| `$GUM_FILTER_FUZZY_SORT` | Boolean — sort fuzzy results by score. |
| `$GUM_FILTER_TIMEOUT` | Timeout until abort. |
| `$GUM_FILTER_INPUT_DELIMITER` | Delimiter reading STDIN (default `"\n"`). |
| `$GUM_FILTER_OUTPUT_DELIMITER` | Delimiter writing STDOUT (default `"\n"`). |
| `$GUM_FILTER_STRIP_ANSI` | Boolean — strip ANSI from STDIN. |
| `$GUM_FILTER_INDICATOR_FOREGROUND` | Indicator foreground (default `212`). |
| `$GUM_FILTER_INDICATOR_BACKGROUND` | Indicator background. |
| `$GUM_FILTER_SELECTED_PREFIX_FOREGROUND` | Selected prefix foreground (default `212`). |
| `$GUM_FILTER_SELECTED_PREFIX_BACKGROUND` | Selected prefix background. |
| `$GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND` | Unselected prefix foreground (default `240`). |
| `$GUM_FILTER_UNSELECTED_PREFIX_BACKGROUND` | Unselected prefix background. |
| `$GUM_FILTER_HEADER_FOREGROUND` | Header foreground (default `99`). |
| `$GUM_FILTER_HEADER_BACKGROUND` | Header background. |
| `$GUM_FILTER_TEXT_FOREGROUND` | Text foreground. |
| `$GUM_FILTER_TEXT_BACKGROUND` | Text background. |
| `$GUM_FILTER_CURSOR_TEXT_FOREGROUND` | Cursor text foreground. |
| `$GUM_FILTER_CURSOR_TEXT_BACKGROUND` | Cursor text background. |
| `$GUM_FILTER_MATCH_FOREGROUND` | Match highlight foreground (default `212`). |
| `$GUM_FILTER_MATCH_BACKGROUND` | Match highlight background. |
| `$GUM_FILTER_PROMPT_FOREGROUND` | Prompt foreground (default `240`). |
| `$GUM_FILTER_PROMPT_BACKGROUND` | Prompt background. |
| `$GUM_FILTER_PLACEHOLDER_FOREGROUND` | Placeholder foreground (default `240`). |
| `$GUM_FILTER_PLACEHOLDER_BACKGROUND` | Placeholder background. |
| `$GUM_FILTER_PADDING` | Padding (default `"0 0"`). |

### Flags

| Flag | Description |
|---|---|
| `--indicator` | Indicator character. |
| `--selected` | Pre-selected options. |
| `--[no-]show-help` | Show help keybinds. |
| `--selected-prefix` | Prefix for selected items. |
| `--unselected-prefix` | Prefix for unselected items. |
| `--header` | Header text. |
| `--placeholder` | Placeholder text. |
| `--prompt` | Prompt text. |
| `--width` | Input width. |
| `--height` | Input height. |
| `--value` | Initial value. |
| `--reverse` | Display from bottom. |
| `--[no-]fuzzy` | Enable fuzzy matching. |
| `--[no-]fuzzy-sort` | Sort by fuzzy score. |
| `--timeout` | Timeout duration. |
| `--input-delimiter` | Delimiter for STDIN. |
| `--output-delimiter` | Delimiter for STDOUT. |
| `--[no-]strip-ansi` | Strip ANSI on STDIN. |
| `--limit=1` | Max options to pick. |
| `--no-limit` | Pick unlimited. |
| `--select-if-one` | Auto-select if only one. |
| `--[no-]strict` | Only return if something matched. |

Style flags: `--indicator.foreground`, `--selected-indicator.foreground`, `--unselected-prefix.foreground`, `--header.foreground`, `--text.foreground`, `--cursor-text.foreground`, `--match.foreground`, `--prompt.foreground`, `--placeholder.foreground`, `--padding`.

### Running

```bash
printf "a\nb\nc" | gum filter --placeholder "Pick..."
gum filter a b c --fuzzy --limit 2
```

---

## gum format

Format a string using Glamour (markdown/template/code/emoji).

### Variables

| Variable | Description |
|---|---|
| `$GUM_FORMAT_THEME` | Glamour theme (default `"pink"`). |
| `$GUM_FORMAT_LANGUAGE` | Language for `code` blocks. |
| `$GUM_FORMAT_STRIP_ANSI` | Boolean — strip ANSI on STDIN. |
| `$GUM_FORMAT_TYPE` | Format type: `markdown` (default), `template`, `code`, `emoji`. |

### Flags

| Flag | Description |
|---|---|
| `--theme="pink"` | Glamour theme. |
| `-l, --language` | Language for code. |
| `--[no-]strip-ansi` | Strip ANSI on STDIN. |
| `-t, --type="markdown"` | Format type. |

### Running

```bash
echo "# Hello" | gum format
gum format --type code --language bash <<< 'echo hi'
```

---

## gum input

Single-line text input.

### Variables

| Variable | Description |
|---|---|
| `$GUM_INPUT_PLACEHOLDER` | Placeholder (default `"Type something..."`). |
| `$GUM_INPUT_PROMPT` | Prompt (default `"> "`). |
| `$GUM_INPUT_CURSOR_MODE` | Cursor mode: `blink` (default), `static`, `hide`. |
| `$GUM_INPUT_WIDTH` | Input width (`0` = terminal width). |
| `$GUM_INPUT_SHOW_HELP` | Boolean — show help keybinds. |
| `$GUM_INPUT_HEADER` | Header text. |
| `$GUM_INPUT_TIMEOUT` | Timeout until abort. |
| `$GUM_INPUT_STRIP_ANSI` | Boolean — strip ANSI on STDIN. |
| `$GUM_INPUT_PROMPT_FOREGROUND` | Prompt foreground. |
| `$GUM_INPUT_PROMPT_BACKGROUND` | Prompt background. |
| `$GUM_INPUT_PLACEHOLDER_FOREGROUND` | Placeholder foreground (default `240`). |
| `$GUM_INPUT_PLACEHOLDER_BACKGROUND` | Placeholder background. |
| `$GUM_INPUT_CURSOR_FOREGROUND` | Cursor foreground (default `212`). |
| `$GUM_INPUT_CURSOR_BACKGROUND` | Cursor background. |
| `$GUM_INPUT_HEADER_FOREGROUND` | Header foreground (default `240`). |
| `$GUM_INPUT_HEADER_BACKGROUND` | Header background. |
| `$GUM_INPUT_PADDING` | Padding (default `"0 0"`). |

### Flags

| Flag | Description |
|---|---|
| `--placeholder` | Placeholder text. |
| `--prompt` | Prompt text. |
| `--cursor.mode` | Cursor mode. |
| `--value` | Initial value (also via STDIN). |
| `--char-limit=400` | Max length (`0` = no limit). |
| `--width` | Input width. |
| `--password` | Mask input. |
| `--[no-]show-help` | Show help keybinds. |
| `--header` | Header text. |
| `--timeout` | Timeout duration. |
| `--[no-]strip-ansi` | Strip ANSI on STDIN. |

Style flags: `--prompt.foreground`, `--placeholder.foreground`, `--cursor.foreground`, `--header.foreground`, `--padding`.

### Running

```bash
gum input --placeholder "Username"
gum input --password --prompt "Password: "
```

---

## gum join

Join text vertically or horizontally.

### Variables

None.

### Flags

| Flag | Description |
|---|---|
| `--align="left"` | Text alignment (`left`, `center`, `right`). |
| `--horizontal` | Join strings horizontally. |
| `--vertical` | Join strings vertically (default). |

### Running

```bash
gum join --horizontal "left" "right"
gum join --vertical "a" "b" "c" --align center
```

---

## gum log

Log messages with level and formatting.

### Variables

| Variable | Description |
|---|---|
| `$GUM_LOG_LEVEL` | Minimal level to show (also `--min-level`). |
| `$GUM_LOG_LEVEL_FOREGROUND` | Level foreground. |
| `$GUM_LOG_LEVEL_BACKGROUND` | Level background. |
| `$GUM_LOG_TIME_FOREGROUND` | Time foreground. |
| `$GUM_LOG_TIME_BACKGROUND` | Time background. |
| `$GUM_LOG_PREFIX_FOREGROUND` | Prefix foreground. |
| `$GUM_LOG_PREFIX_BACKGROUND` | Prefix background. |
| `$GUM_LOG_MESSAGE_FOREGROUND` | Message foreground. |
| `$GUM_LOG_MESSAGE_BACKGROUND` | Message background. |
| `$GUM_LOG_KEY_FOREGROUND` | Key foreground. |
| `$GUM_LOG_KEY_BACKGROUND` | Key background. |
| `$GUM_LOG_VALUE_FOREGROUND` | Value foreground. |
| `$GUM_LOG_VALUE_BACKGROUND` | Value background. |
| `$GUM_LOG_SEPARATOR_FOREGROUND` | Separator foreground. |
| `$GUM_LOG_SEPARATOR_BACKGROUND` | Separator background. |

See `ref/gum-log.md` for levels (`none`, `debug`, `info`, `warn`, `error`, `fatal`), formatters (`text`, `json`, `logfmt`), and time formats.

### Flags

| Flag | Description |
|---|---|
| `-o, --file=STRING` | Log to file. |
| `-f, --format` | Format message using `printf`. |
| `--formatter="text"` | Formatter: `text`, `json`, `logfmt`. |
| `-l, --level="none"` | Log level. |
| `--prefix=STRING` | Prefix before message. |
| `-s, --structured` | Structured logging (key=value). |
| `-t, --time=""` | Time format (kitchen, rfc3339, etc). |
| `--min-level=""` | Minimal level to show (`$GUM_LOG_LEVEL`). |

Style flags: `--level.foreground`, `--time.foreground`, `--prefix.foreground`, `--message.foreground`, `--key.foreground`, `--value.foreground`, `--separator.foreground` (+ backgrounds).

### Running

```bash
gum log --level info "starting"
gum log --level error --prefix "setup" "failed"
```

---

## gum pager

Scroll through content (pager).

### Variables

| Variable | Description |
|---|---|
| `$GUM_PAGER_TIMEOUT` | Timeout until exit (`0s` = no timeout). |
| `$GUM_PAGER_FOREGROUND` | Foreground. |
| `$GUM_PAGER_BACKGROUND` | Background. |
| `$GUM_PAGER_LINE_NUMBER_FOREGROUND` | Line number foreground (default `237`). |
| `$GUM_PAGER_LINE_NUMBER_BACKGROUND` | Line number background. |
| `$GUM_PAGER_MATCH_FOREGROUND` | Search match foreground (default `212`). |
| `$GUM_PAGER_MATCH_BACKGROUND` | Search match background. |
| `$GUM_PAGER_MATCH_HIGH_FOREGROUND` | Current match highlight foreground (default `235`). |
| `$GUM_PAGER_MATCH_HIGH_BACKGROUND` | Current match highlight background (default `225`). |
| `$GUM_PAGER_HELP_FOREGROUND` | Help foreground (default `241`). |
| `$GUM_PAGER_HELP_BACKGROUND` | Help background. |

### Flags

| Flag | Description |
|---|---|
| `--show-line-numbers` | Show line numbers. |
| `--[no-]soft-wrap` | Soft wrap lines. |
| `--timeout` | Timeout until exit. |

Style flags: `--foreground`, `--background`, `--line-number.foreground`, `--match.foreground`, `--match-highlight.foreground`, `--help.foreground`.

### Running

```bash
gum pager < README.md
cat file.txt | gum pager --show-line-numbers
```

---

## gum spin

Display a spinner while running a command.

### Variables

| Variable | Description |
|---|---|
| `$GUM_SPIN_SHOW_OUTPUT` | Show both STDOUT and STDERR during execution. |
| `$GUM_SPIN_SHOW_ERROR` | Show output only if command fails. |
| `$GUM_SPIN_SHOW_STDOUT` | Show STDOUT. |
| `$GUM_SPIN_SHOW_STDERR` | Show STDERR. |
| `$GUM_SPIN_SPINNER` | Spinner type (default `"dot"`). |
| `$GUM_SPIN_TITLE` | Title text (default `"Loading..."`). |
| `$GUM_SPIN_ALIGN` | Alignment of spinner vs title (`left`, `center`, `right`). |
| `$GUM_SPIN_TIMEOUT` | Timeout until abort. |
| `$GUM_SPIN_SPINNER_FOREGROUND` | Spinner foreground (default `212`). |
| `$GUM_SPIN_SPINNER_BACKGROUND` | Spinner background. |
| `$GUM_SPIN_TITLE_FOREGROUND` | Title foreground. |
| `$GUM_SPIN_TITLE_BACKGROUND` | Title background. |
| `$GUM_SPIN_PADDING` | Padding (default `"0 0"`). |

### Flags

All variables are flags: `--show-output`, `--show-error`, `--show-stdout`, `--show-stderr`, `-s/--spinner`, `--title`, `-a/--align`, `--timeout`, plus `--spinner.foreground`, `--title.foreground`, `--padding`.

### Running

```bash
gum spin --title "Installing..." -- sleep 2
gum spin --spinner dot --title "Processing..." -- ./scripts/modules/260901abbc.sh
```

---

## gum style

Apply color, border, spacing to text. This repo uses `prt_info` in `ref/gumVariables.md` to set `$FOREGROUND`/`$BOLD` per `info`/`msg`/`win`/`lose`.

### Variables

| Variable | Description |
|---|---|
| `$FOREGROUND` | Foreground color (0-255 or hex). |
| `$BACKGROUND` | Background color. |
| `$BORDER` | Border style: `none`, `hidden`, `normal`, `rounded`, `thick`, `double`. |
| `$BORDER_BACKGROUND` | Border background. |
| `$BORDER_FOREGROUND` | Border foreground. |
| `$ALIGN` | Alignment: `left`, `center`, `right`. |
| `$HEIGHT` | Text height (`0` = auto). |
| `$WIDTH` | Text width (`0` = auto). |
| `$MARGIN` | Margin (e.g. `"1 2"`). |
| `$PADDING` | Padding (e.g. `"0 1"`). |
| `$BOLD` | Boolean — bold. |
| `$FAINT` | Boolean — faint. |
| `$ITALIC` | Boolean — italic. |
| `$STRIKETHROUGH` | Boolean — strikethrough. |
| `$UNDERLINE` | Boolean — underline. |
| `$GUM_STYLE_STRIP_ANSI` | Boolean — strip ANSI on STDIN. |

### Flags

| Flag | Description |
|---|---|
| `--trim` | Trim whitespace on each input line. |
| `--[no-]strip-ansi` | Strip ANSI on STDIN. |

Plus style flags: `--foreground`, `--background`, `--border`, `--border-foreground`, `--align`, `--height`, `--width`, `--margin`, `--padding`, `--bold`, etc.

### Running

```bash
style=win; prt_info; gum style "Success"
gum style --foreground 212 --bold "Hello"
```

---

## gum table

Render a table / pick a row.

### Variables

| Variable | Description |
|---|---|
| `$GUM_TABLE_SHOW_HELP` | Boolean — show help keybinds. |
| `$GUM_TABLE_HIDE_COUNT` | Boolean — hide item count in help. |
| `$GUM_TABLE_LAZY_QUOTES` | Boolean — allow lazy quotes in CSV. |
| `$GUM_TABLE_FIELDS_PER_RECORD` | Expected fields per record (`0` = auto). |
| `$GUM_TABLE_TIMEOUT` | Timeout until abort. |
| `$GUM_TABLE_BORDER_FOREGROUND` | Border foreground. |
| `$GUM_TABLE_BORDER_BACKGROUND` | Border background. |
| `$GUM_TABLE_CELL_FOREGROUND` | Cell foreground. |
| `$GUM_TABLE_CELL_BACKGROUND` | Cell background. |
| `$GUM_TABLE_HEADER_FOREGROUND` | Header foreground. |
| `$GUM_TABLE_HEADER_BACKGROUND` | Header background. |
| `$GUM_TABLE_SELECTED_FOREGROUND` | Selected row foreground (default `212`). |
| `$GUM_TABLE_SELECTED_BACKGROUND` | Selected row background. |
| `$GUM_TABLE_PADDING` | Padding (default `"0 0"`). |

### Flags

| Flag | Description |
|---|---|
| `-s, --separator=","` | Field separator. |
| `-c, --columns=...` | Column names. |
| `-w, --widths=...` | Column widths. |
| `--height=0` | Table height (`0` = auto). |
| `-p, --print` | Static print (no interaction). |
| `-f, --file=""` | File path to read. |
| `-b, --border="rounded"` | Border style. |
| `-r, --return-column=0` | Column to return (`0` = whole row). |
| `--[no-]show-help` | Show help keybinds. |
| `--[no-]hide-count` | Hide item count. |
| `--lazy-quotes` | Lazy quotes. |
| `--fields-per-record` | Fields per record. |
| `--timeout` | Timeout duration. |

Style flags: `--border.foreground`, `--cell.foreground`, `--header.foreground`, `--selected.foreground`, `--padding`.

### Running

```bash
printf "a,b\nc,d" | gum table --columns "X,Y" --print
gum table --file data.csv --columns "Name,Url,Commit"
```

---

## gum write

Multi-line text input (editor).

### Variables

| Variable | Description |
|---|---|
| `$GUM_WRITE_WIDTH` | Text area width (`0` = terminal width). |
| `$GUM_WRITE_HEIGHT` | Text area height (default `5`). |
| `$GUM_WRITE_HEADER` | Header text. |
| `$GUM_WRITE_PLACEHOLDER` | Placeholder (default `"Write something..."`). |
| `$GUM_WRITE_PROMPT` | Prompt (default `"┃ "`). |
| `$GUM_WRITE_SHOW_CURSOR_LINE` | Show cursor line. |
| `$GUM_WRITE_SHOW_LINE_NUMBERS` | Show line numbers. |
| `$GUM_WRITE_VALUE` | Initial value (also via STDIN). |
| `$GUM_WRITE_SHOW_HELP` | Boolean — show help keybinds. |
| `$GUM_WRITE_CURSOR_MODE` | Cursor mode: `blink` (default), `static`, `hide`. |
| `$GUM_WRITE_TIMEOUT` | Timeout until abort. |
| `$GUM_WRITE_STRIP_ANSI` | Boolean — strip ANSI on STDIN. |
| `$GUM_WRITE_BASE_FOREGROUND` | Base foreground. |
| `$GUM_WRITE_BASE_BACKGROUND` | Base background. |
| `$GUM_WRITE_CURSOR_LINE_NUMBER_FOREGROUND` | Cursor line number foreground (default `7`). |
| `$GUM_WRITE_CURSOR_LINE_NUMBER_BACKGROUND` | Cursor line number background. |
| `$GUM_WRITE_CURSOR_LINE_FOREGROUND` | Cursor line foreground. |
| `$GUM_WRITE_CURSOR_LINE_BACKGROUND` | Cursor line background. |
| `$GUM_WRITE_CURSOR_FOREGROUND` | Cursor foreground (default `212`). |
| `$GUM_WRITE_CURSOR_BACKGROUND` | Cursor background. |
| `$GUM_WRITE_END_OF_BUFFER_FOREGROUND` | End-of-buffer foreground (default `0`). |
| `$GUM_WRITE_END_OF_BUFFER_BACKGROUND` | End-of-buffer background. |
| `$GUM_WRITE_LINE_NUMBER_FOREGROUND` | Line number foreground (default `7`). |
| `$GUM_WRITE_LINE_NUMBER_BACKGROUND` | Line number background. |
| `$GUM_WRITE_HEADER_FOREGROUND` | Header foreground (default `240`). |
| `$GUM_WRITE_HEADER_BACKGROUND` | Header background. |
| `$GUM_WRITE_PLACEHOLDER_FOREGROUND` | Placeholder foreground (default `240`). |
| `$GUM_WRITE_PLACEHOLDER_BACKGROUND` | Placeholder background. |
| `$GUM_WRITE_PROMPT_FOREGROUND` | Prompt foreground (default `7`). |
| `$GUM_WRITE_PROMPT_BACKGROUND` | Prompt background. |
| `$GUM_WRITE_PADDING` | Padding (default `"0 0"`). |

### Flags

| Flag | Description |
|---|---|
| `--width` | Text area width. |
| `--height` | Text area height. |
| `--header` | Header text. |
| `--placeholder` | Placeholder text. |
| `--prompt` | Prompt text. |
| `--show-cursor-line` | Show cursor line. |
| `--show-line-numbers` | Show line numbers. |
| `--value` | Initial value. |
| `--char-limit=0` | Max length (`0` = no limit). |
| `--max-lines=0` | Max lines (`0` = no limit). |
| `--[no-]show-help` | Show help keybinds. |
| `--cursor.mode` | Cursor mode. |
| `--timeout` | Timeout duration. |
| `--[no-]strip-ansi` | Strip ANSI on STDIN. |

Style flags: `--base.foreground`, `--cursor-line-number.foreground`, `--cursor-line.foreground`, `--cursor.foreground`, `--end-of-buffer.foreground`, `--line-number.foreground`, `--header.foreground`, `--placeholder.foreground`, `--prompt.foreground`, `--padding`.

### Running

```bash
gum write --header "Commit message" --placeholder "Describe change..."
```

---

## Project Usage

This repo currently uses `gum confirm`, `gum choose`, `gum style` (via `prt_info`), and `gum spin`. Defaults are exported in `ref/gumVariables.md` and inlined in `scripts/menus/setup.sh:62-89` and `scripts/modules/*.sh`. Colors use 8/256-color codes: `info` 7 (white, bold), `msg` 3 (yellow), `win` 2 (green, bold), `lose` 1 (red, bold).

`file`, `filter`, `input`, `pager`, `table`, `write`, `log`, `format`, and `join` are documented for future `tools/` and `scripts/menus/de-select.sh` use.
