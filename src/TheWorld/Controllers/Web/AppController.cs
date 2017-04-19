using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using TheWorld.Services;
using TheWorld.ViewModels;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using TheWorld.Models;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace TheWorld.Controllers.Web
{
    public class AppController : Controller
    {
        private IMailService _mailService;
        private IConfigurationRoot _config;
        private WorldContext _context;

        public AppController(IMailService mailService, IConfigurationRoot config, WorldContext context)
        {
            _mailService = mailService;
            _config = config;
            _context = context;
        }

        public IActionResult Index()
        {
           var data = _context.Trips.ToList(); //list that will go to the database
           return View(data);
            //return View();
        }

        public IActionResult Contact()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Contact(ContactViewModel model)
        {   
            // example of asp-validation-summary error
           // if(model.Email.Contains("aol.com")) ModelState.AddModelError("Email","We don't support that email");

            if(ModelState.IsValid)
            { _mailService.SendMail(_config["MailSettings:ToAddress"],model.Email, "From TheWorld", model.Message);} 

            ModelState.Clear();
            ViewBag.UserMesssage = "Message Sent";

            return View();
        }

        public IActionResult About()
        {
            return View(); //views are found 'cause we specified that in startup.cs file Configure()
        }

    }
}
