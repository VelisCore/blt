from rich.console import Console
from rich.panel import Panel
from rich import box
from debloat import core

def main():
    console = Console()
    console.print(Panel.fit(
        "[bold cyan]:rocket: BLT - Windows Debloater Tool :rocket:[/bold cyan]\n"
        "[green]Vereint 40+ Windows-Optimierungen - Schnell & Sicher![/green]",
        box=box.ROUNDED,
        padding=(1, 4),
        subtitle="by YourName",
        title="blt",
    ))

    core.main_menu(console)

if __name__ == "__main__":
    main()