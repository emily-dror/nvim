
-- Python files
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.py",
    callback = function()
        vim.api.nvim_buf_set_lines(
            0, 0, 0, false, {
                "#!/usr/bin/env python3",
                "# pylint: disable=all",
                "",
                "def main():",
                "    pass",
                "",
                "if __name__ == \"__main__\":",
                "    main()",
            }
        )
    end,
})

-- Makefile files
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "Makefile",
    callback = function()
        vim.api.nvim_buf_set_lines(
            0, 0, 0, false, {
                "COMPILER := clang",
                "COMPILER_FLAGS := -std=c99 -Wextra -Wpedantic",
                "SRCS := main.c",
                "OBJS=$(subst .c,.o,$(SRCS))",
                "HDRS := main.h",
                "BIN := main",
                "ZIP := sub",
                "",
                "$(BIN): $(OBJS)",
                "	$(COMPILER) $(COMPILER_FLAGS) $^ -o $@",
                "",
                "$(OBJS): %.o: %.c",
                "	$(COMPILER) $(COMPILER_FLAGS) -c $^",
                "",
                "zip: $(SRCS) $(HDRS)",
                "	zip $(ZIP).zip $^ Makefile",
                "",
                "clean:",
                "	rm -rf $(BIN) $(OBJS)",
                "	rm -rf $(ZIP).zip",
            }
        )
    end,
})

-- C files
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.c",
    callback = function()
        vim.api.nvim_buf_set_lines(
            0, 0, 0, false, {
                "#include <stdio.h>",
                "",
                "int main(int argc, char *argv[])",
                "{",
                "    printf(\"Hello, world!\\n\");",
                "    return 0;",
                "}",
            }
        )
    end,
})

-- C files
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.c",
    callback = function()
        vim.cmd("silent! !clang-format -i %")
        vim.cmd("edit!")
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.cpp",
    callback = function()
        vim.cmd("silent! !clang-format -i %")
        vim.cmd("edit!")
    end,
})


-- C++ files
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cpp",
    callback = function()
        vim.api.nvim_buf_set_lines(
            0, 0, 0, false, {
                "#include <iostream>",
                "",
                "int main (int argc, char *argv[]) {",
                "    std::cout << \"Hello, world!\" << std::endl;",
                "    return 0;",
                "}",
            }
        )
    end,
})

-- clang-format files
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = ".clang-format",
    callback = function()
        vim.api.nvim_buf_set_lines(
            0, 0, 0, false, {
            "---",
            "BasedOnStyle:  Google",
            "AccessModifierOffset: -4",
            "AlignConsecutiveAssignments: true",
            "AllowShortCaseLabelsOnASingleLine: true",
            "AllowShortFunctionsOnASingleLine: Inline",
            "BraceWrapping:",
            "  AfterClass:      true",
            "  AfterControlStatement: false",
            "  AfterEnum:       true",
            "  AfterFunction:   true",
            "  AfterNamespace:  false",
            "  AfterObjCDeclaration: false",
            "  AfterStruct:     true",
            "  AfterUnion:      true",
            "  BeforeCatch:     false",
            "  BeforeElse:      false",
            "  IndentBraces:    false",
            "BreakBeforeBraces: Custom",
            "BreakBeforeBinaryOperators: All",
            "BreakConstructorInitializersBeforeComma: true",
            "BreakInheritanceList: BeforeComma",
            "ConstructorInitializerAllOnOneLineOrOnePerLine: false",
            "DerivePointerAlignment: false",
            "IndentWidth:     4",
            "IncludeCategories:",
            "  - Regex:           '^\".*\"'",
            "    Priority:        1",
            "  - Regex:           '^<.*\\.h>'",
            "    Priority:        2",
            "  - Regex:           '^<.*'",
            "    Priority:        3",
            "  - Regex:           '.*'",
            "    Priority:        4",
            "PointerAlignment: Right",
            "SpacesInCStyleCastParentheses: false",
            "ObjCBlockIndentWidth: 4",
            "ColumnLimit: 100",
            "---",
            "Language:        Cpp",
            "---",
            "Language:        ObjC"
            }
        )
    end,
})


