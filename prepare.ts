const clean = new Deno.Command("deno", { args: ["clean"] });
try { clean.outputSync(); } catch { /* ignore */ }
try { Deno.removeSync("node_modules", { recursive: true }); } catch { /* ignore */ }
try { Deno.removeSync("deno.lock"); } catch { /* ignore */ }
