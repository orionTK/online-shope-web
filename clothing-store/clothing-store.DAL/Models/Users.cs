using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Users
    {
        public Users()
        {
            Carts = new HashSet<Carts>();
            Orders = new HashSet<Orders>();
            Transactions = new HashSet<Transactions>();
        }

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string Dob { get; set; }
      
        public int RoleId { get; set; }

        public virtual RoleUser Role { get; set; }
        public virtual ICollection<Carts> Carts { get; set; }
        public virtual ICollection<Orders> Orders { get; set; }
        public virtual ICollection<Transactions> Transactions { get; set; }
    }
}
