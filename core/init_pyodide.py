from core import translation as t
from core.text import load_chapters


def init(lang):
    lang = "fr"
    t.set_language(lang)
    # if lang and lang != "en":
    #     t.set_language(lang)

    list(load_chapters())
