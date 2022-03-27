module golphook

#flag -I @VMODROOT/exts/bass
#flag -I @VMODROOT/exts/subhook
#flag -I @VMODROOT/exts/minhook

#flag -L @VMODROOT/exts/bass
#flag -L @VMODROOT/exts/minhook

#flag -l minhook

#include "windows.h"
#include "minhook.h"

// windows defs

fn C.MessageBoxA(int, &char, &char, int) int
fn C.FreeLibraryAndExitThread(voidptr, u32) bool
fn C.Beep(u32, u32) bool
fn C.GetModuleHandleA(&char) C.HMODULE
fn C.GetProcAddress(C.HMODULE, &char) voidptr

// minhook defs

fn C.MH_Initialize() int
fn C.MH_CreateHook(voidptr, voidptr, &voidptr) int
fn C.MH_EnableHook(voidptr) int
fn C.MH_DisableHook(voidptr) int
fn C.MH_Uninitialize() int
