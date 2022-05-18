#region snippet_IsAdmin
[Authorize]
public class PizzaModel : PageModel
{
    public bool IsAdmin => HttpContext.User.HasClaim("IsAdmin", bool.TrueString);

    public List<Pizza> pizzas = new();
#endregion

#region snippet_OnGet
[Authorize]
public void OnGet()
{
    pizzas = PizzaService.GetAll();
}
#endregion

#region snippet_AdminCheck
public IActionResult OnPost()
{
    if (!IsAdmin) return Forbid();
    if (!ModelState.IsValid)
    {
        return Page();
    }
    PizzaService.Add(NewPizza);
    return RedirectToAction("Get");
}

public IActionResult OnPostDelete(int id)
{
    if (!IsAdmin) return Forbid();
    PizzaService.Delete(id);
    return RedirectToAction("Get");
}
#endregion

}
