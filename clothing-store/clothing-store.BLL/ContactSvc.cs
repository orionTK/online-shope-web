using System;
using System.Collections.Generic;
using System.Text;

using clothing_store.Common.Rsp;
using clothing_store.Common.BLL;

namespace clothing_store.BLL
{
    using clothing_store.Common.Req;
    using clothing_store.DAL.Models;
    using DAL;
    using System.Linq;
    using System.Reflection.Metadata.Ecma335;

    //public class ContactSvc : GenericSvc<ContactRep, Contact>
    //{
    //    #region -- Overrides --
    //    public override SingleRsp Read(int id)
    //    {
    //        var res = new SingleRsp();

    //        var m = _rep.Read(id);
    //        res.Data = m;

    //        return res;
    //    }

        
    //    #endregion

    //    // 
    //    //public SingleRsp CreateContact(ContactReq contact)
    //    //{
    //    //    var res = new SingleRsp();
    //    //    Contact contacts = new Contact();
    //    //    contacts.ContactId = contact.ContactId;
    //    //    contacts.Name = contact.Name;
    //    //    contacts.Email = contact.Email;
    //    //    contacts.PhoneNumber = contact.PhoneNumber;
    //    //    contacts.Message = contact.Message;

    //    //    res = _rep.CreateContact(contacts);
    //    //    return res;
    //    //}

       
    //}
}
