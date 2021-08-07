using clothing_store.Common.BLL;
using clothing_store.Common.Req;
using clothing_store.Common.Rsp;
using clothing_store.DAL;
using clothing_store.DAL.Models;
using System;
using System.Linq;

namespace clothing_store.BLL
{
    public class UsersSvc : GenericSvc<UsersRep, Users>
    {
        #region -- Override --
        public override SingleRsp Read(int id)
        {
            var res = new SingleRsp();

            var m = _rep.Read(id);
            res.Data = m;

            return res;
        }

        public SingleRsp CreateUser(UsersReq use)
        {
            var res = new SingleRsp();
            Users users = new Users();
            users.UserName = use.UserName;
            users.Password = use.PassWord;
            users.PhoneNumber = use.PhoneNumber;
            users.Email = use.Email;
            users.Dob = use.Dob;
            users.RoleId = use.RoleId;

            res = _rep.CreateUser(users);
            return res;
        }
        public int DeleteUser(int id)
        {
            return _rep.DeleteUser(id);
        }
        #endregion

        #region -- Methods --

        public SingleRsp UpdateUser(int UserId, string UserName, string Password, string PhoneNumber, string Dob, string Email, int RoleId)
        {
            var res = new SingleRsp();
            res = _rep.UpdateUser(UserId, UserName, Password, PhoneNumber, Dob, Email, RoleId);
            return res;
        }

        public object SearchUser(String keyword, int page, int size)
        {
            var pro = All.Where(x => x.UserName.Contains(keyword));

            var offset = (page - 1) * size;
            var total = pro.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var data = pro.OrderBy(x => x.UserName).Skip(offset).Take(size).ToList();

            var res = new
            {
                Data = data,
                TotalRecord = total,
                TotalPages = totalPages,
                Page = page,
                Size = size
            };
            return res;
        }
        public object CheckAcc_Linq(String username)
        {
            return _rep.CheckAcc_Linq(username);
        }
    
        #endregion
    }
}
