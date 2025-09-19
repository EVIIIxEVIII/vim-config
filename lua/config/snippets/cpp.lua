local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
    s("cf", {
        t({
            "#include <bits/stdc++.h>",
            "using namespace std;",
            "",
            "int main() {",
            "    ios::sync_with_stdio(false);",
            "    cin.tie(nullptr);",
            "",
            "    int t; cin >> t;",
            "    while (t--) {",
            "        ",
        }),
        i(0),
        t({
            "",
            "    }",
            "    return 0;",
            "}",
        }),
    }),
}

