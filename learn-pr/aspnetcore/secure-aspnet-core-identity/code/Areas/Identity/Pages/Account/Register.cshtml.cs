var user = new ContosoPetsUser
{
    FirstName = Input.FirstName,
    LastName = Input.LastName,
    UserName = Input.Email,
    Email = Input.Email,
    IsAdmin = (Input.AdminCreationKey == _adminService.CreationKey),
};
