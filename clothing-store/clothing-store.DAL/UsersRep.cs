using clothing_store.Common.DAL;
using clothing_store.Common.Rsp;
using clothing_store.DAL.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace clothing_store.DAL
{
    public class UsersRep : GenericRep<OnlineStoreContext, Users>
    {
        public override Users Read(int id)
        {
            var res = All.FirstOrDefault(u => u.UserId == id);
            return res;
        }
        public SingleRsp CreateUser(Users users)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Users.Add(users);
                        context.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        res.SetError(ex.StackTrace);
                    }
                }
            }
            return res;
        }

        public int DeleteUser(int id)
        {
            var res = 0;
            var context = new OnlineStoreContext();
            var use = base.All.FirstOrDefault(u => u.UserId == id);
            if (use != null)
            {
                context.Users.Remove(use);
                res = context.SaveChanges();
            }
            return res;
        }

        public SingleRsp UpdateUser(int UserId, string UserName, string Password, string PhoneNumber, string Dob, string Email, int RoleId)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        Users use = Context.Users.Where(x => x.UserId == UserId).ToList().FirstOrDefault();
                        use.UserName = UserName;
                        use.Password = Password;
                        use.PhoneNumber = PhoneNumber;
                        use.Dob = Dob;
                        use.Email = Email;
                        use.RoleId = RoleId;
                        var t = context.Users.Update(use);
                        context.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        res.SetError(ex.StackTrace);
                    }
                }
            }
            return res;
        }

        public object CheckAcc_Linq(String username)
        {
            var res = Context.Users
                .Where(x => x.UserName == username)
                .Select(u => new {
                    u.UserId,
                    u.RoleId,
                    u.Password
                }).ToList();
            return res;
        }

    }
}
