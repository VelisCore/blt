import os
import questionary
from rich.console import Console
from utils.ps_runner import run_ps_script

script_dir = os.path.join(os.path.dirname(__file__), 'powershell')

debloat_actions = [
    {"name": "OneDrive entfernen", "script": "remove_onedrive.ps1"},
    {"name": "Telemetry deaktivieren", "script": "remove_telemetry.ps1"},
    {"name": "Microsoft Edge entfernen", "script": "remove_edge.ps1"},
    {"name": "Xbox Apps entfernen", "script": "remove_xbox.ps1"},
    {"name": "Cortana entfernen/deaktivieren", "script": "remove_cortana.ps1"},
    {"name": "3D Viewer entfernen", "script": "remove_3dviewer.ps1"},
    {"name": "Skype entfernen", "script": "remove_skype.ps1"},
    {"name": "News & Interests deaktivieren", "script": "remove_news.ps1"},
    {"name": "Vorinstallierte Office-Apps entfernen", "script": "remove_office_apps.ps1"},
    {"name": "Karten-App entfernen", "script": "remove_maps.ps1"},
    {"name": "Windows Defender deaktivieren", "script": "disable_windows_defender.ps1"},
    {"name": "Bing-Suche deaktivieren", "script": "remove_bing_search.ps1"},
    {"name": "People Bar deaktivieren", "script": "remove_people.ps1"},
    {"name": "Feedback Hub entfernen", "script": "remove_feedback_hub.ps1"},
    {"name": "Solitaire Collection entfernen", "script": "remove_solitaire.ps1"},
    {"name": "Alle (Empfohlen!)", "script": None}  # Sonderfunktion, führt alles aus
]

def main_menu(console: Console):
    while True:
        options = [action["name"] for action in debloat_actions] + ["Beenden"]
        answer = questionary.select("Wähle eine Aktion:", choices=options).ask()
        if answer == "Beenden" or answer is None:
            break
        if answer == "Alle (Empfohlen!)":
            for action in debloat_actions[:-1]:
                run_ps_script(console, os.path.join(script_dir, action["script"]), action["name"])
        else:
            action = next(a for a in debloat_actions if a["name"] == answer)
            run_ps_script(console, os.path.join(script_dir, action["script"]), answer)