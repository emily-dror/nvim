
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
