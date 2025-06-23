from rich.console import Console
from rich.panel import Panel
from rich import box
from debloat import core

def main():
    console = Console()
    console.print(
        Panel.fit(
            "[bold cyan]:rocket: BLT – Windows Debloater Tool :rocket:[/bold cyan]\n"
            "[green]Vereint über 10 Windows-Optimierungen – schnell und sicher![/green]",
            box=box.ROUNDED,
            padding=(1, 4),
            subtitle="by Velis",
            title="BLT",
        )
    )

    core.main_menu(console)

if __name__ == "__main__":
    main()