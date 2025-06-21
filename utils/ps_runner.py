import subprocess

def run_ps_script(console, script_path, title):
    try:
        with open(script_path, "r", encoding="utf-8") as file:
            script_content = file.read()
        console.rule(f"[bold]{title}[/bold]")
        process = subprocess.run(
            ["powershell", "-NoProfile", "-ExecutionPolicy", "Unrestricted", "-Command", script_content],
            capture_output=True, text=True)
        if process.returncode == 0:
            console.print(f":white_check_mark: [green]{title} erfolgreich![/green]")
        else:
            console.print(f":x: [red]{title} fehlgeschlagen![/red]\n[italic]{process.stderr}[/italic]")
    except Exception as e:
        console.print(f"[red]Fehler:[/red] {e}")